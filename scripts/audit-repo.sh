#!/usr/bin/env bash
# audit-repo.sh
# REPO_STANDARDS.md compliance audit for thornveil-ai repos.
#
# Idempotent. Read-only. No mutations. Requires `gh` CLI authenticated as org admin.
#
# Usage:
#   bash audit-repo.sh <repo-name>            # auto-detects tier from repo name
#   bash audit-repo.sh <repo-name> 1          # force Tier 1 (public OSS)
#   bash audit-repo.sh <repo-name> 2          # force Tier 2 (private proprietary)
#   bash audit-repo.sh <repo-name> 3          # force Tier 3 (export-controlled)
#   bash audit-repo.sh <repo-name> companion  # public marketing companion
#
# Exit code: 0 if no FAILs, 1 if any FAIL emitted. WARNs do not affect exit code.
#
# Reference: thornveil-ai/.github/REPO_STANDARDS.md sections 3, 5, 6c, 6d, 6g, 14

set -uo pipefail

REPO="${1:?usage: bash audit-repo.sh <repo-name> [tier]}"
TIER="${2:-auto}"

# ---------- Tier auto-detect ----------
if [ "$TIER" = "auto" ]; then
  case "$REPO" in
    signet|alchemist)
      TIER="1" ;;
    auspex)
      TIER="3" ;;
    meridian|pyros|canopy|hawkstack|rigrun|mycelium|navigator)
      TIER="2" ;;
    *-overview|*-paper|*-preview|*-contact|*-core)
      TIER="companion" ;;
    *)
      TIER="unknown" ;;
  esac
fi

# ---------- Counters + emit helper ----------
PASS=0; FAIL=0; WARN=0

emit() {
  local status="$1" label="$2" detail="${3:-}"
  case "$status" in
    PASS) printf "  [PASS] %-50s %s\n" "$label" "$detail"; PASS=$((PASS+1)) ;;
    FAIL) printf "  [FAIL] %-50s %s\n" "$label" "$detail"; FAIL=$((FAIL+1)) ;;
    WARN) printf "  [WARN] %-50s %s\n" "$label" "$detail"; WARN=$((WARN+1)) ;;
  esac
}

# ---------- API helpers ----------
# Note: `gh api` writes the error JSON to stdout on 404. Without explicit
# exit-code checks, callers would treat the error body as content. Both
# helpers below check `$?` and return empty on any non-zero exit.

fetch_content() {
  # Fetch raw content of a path; returns empty if missing or error.
  local b64
  b64=$(gh api "repos/thornveil-ai/$REPO/contents/$1" --jq '.content' 2>/dev/null)
  if [ "$?" -eq 0 ] && [ -n "$b64" ]; then
    echo "$b64" | base64 -d 2>/dev/null
  fi
}

file_exists() {
  # Returns SHA if path exists, empty otherwise.
  local sha
  sha=$(gh api "repos/thornveil-ai/$REPO/contents/$1" --jq '.sha' 2>/dev/null)
  if [ "$?" -eq 0 ] && [ -n "$sha" ]; then
    echo "$sha"
  fi
}

# ---------- Header ----------
echo "=== Audit: thornveil-ai/$REPO (Tier $TIER) ==="
echo

# ===========================================================================
# CHECK 1 — Required files presence (REPO_STANDARDS.md §3)
# ===========================================================================
echo "[1] Required files presence"
for f in README.md LICENSE CHANGELOG.md SECURITY.md .gitignore .github/CODEOWNERS .github/workflows/label-sync.yml; do
  if [ -n "$(file_exists "$f")" ]; then
    emit PASS "$f present"
  else
    # CHANGELOG/SECURITY are required everywhere; .github files required everywhere
    emit FAIL "$f present" "MISSING"
  fi
done
echo

# ===========================================================================
# CHECK 2 — LICENSE content matches tier (REPO_STANDARDS.md §5)
# ===========================================================================
echo "[2] LICENSE content matches Tier $TIER boilerplate"
LICENSE_CONTENT=$(fetch_content LICENSE)
if [ -z "$LICENSE_CONTENT" ]; then
  emit FAIL "LICENSE content" "FILE EMPTY OR MISSING"
else
  case "$TIER" in
    1|companion)
      # Tier 1: Apache-2.0 + Copyright YYYY Thornveil LLC
      if echo "$LICENSE_CONTENT" | grep -q "Apache License"; then
        if echo "$LICENSE_CONTENT" | grep -qE "Copyright [0-9]{4}.*Thornveil"; then
          emit PASS "LICENSE Apache-2.0 + Thornveil copyright"
        else
          emit WARN "LICENSE Apache-2.0 missing or wrong Thornveil copyright line"
        fi
      else
        emit FAIL "LICENSE not Apache-2.0"
      fi
      ;;
    2)
      # Tier 2: Proprietary block with specific phrasing
      if echo "$LICENSE_CONTENT" | grep -qiE "proprietary and confidential"; then
        if echo "$LICENSE_CONTENT" | grep -qE "Copyright \(c\) [0-9]{4} Thornveil LLC"; then
          emit PASS "LICENSE Tier 2 proprietary boilerplate"
        else
          emit WARN "LICENSE Tier 2 proprietary but copyright line nonstandard"
        fi
      else
        emit FAIL "LICENSE Tier 2 missing 'proprietary and confidential' phrasing"
      fi
      ;;
    3)
      # Tier 3: Proprietary + ECCN 4D004 preamble
      if echo "$LICENSE_CONTENT" | grep -qiE "ECCN 4D004|EXPORT-CONTROLLED"; then
        emit PASS "LICENSE Tier 3 ECCN 4D004 preamble"
      else
        emit FAIL "LICENSE Tier 3 missing ECCN 4D004 preamble"
      fi
      ;;
    *)
      emit WARN "LICENSE tier-unknown; manual review"
      ;;
  esac
fi
echo

# ===========================================================================
# CHECK 3 — SECURITY.md content
# ===========================================================================
echo "[3] SECURITY.md content"
SECURITY_CONTENT=$(fetch_content SECURITY.md)
if [ -z "$SECURITY_CONTENT" ]; then
  emit FAIL "SECURITY.md content" "EMPTY OR MISSING"
else
  # Either real content OR proper redirect
  if echo "$SECURITY_CONTENT" | grep -qiE "thornveil-ai/\.github|security@thornveil\.ai|org-wide SECURITY"; then
    LINES=$(echo "$SECURITY_CONTENT" | wc -l)
    if [ "$LINES" -lt 20 ]; then
      emit PASS "SECURITY.md redirect-style (concise, links to org policy)"
    else
      emit PASS "SECURITY.md substantive content with org link"
    fi
  else
    emit WARN "SECURITY.md present but no link to org policy" "($(echo "$SECURITY_CONTENT" | head -1 | cut -c1-50))"
  fi
fi
echo

# ===========================================================================
# CHECK 4 — .gitignore language-appropriate
# ===========================================================================
echo "[4] .gitignore language-appropriate"
GITIGNORE=$(fetch_content .gitignore)
LANG=$(gh api "repos/thornveil-ai/$REPO" --jq '.language' 2>/dev/null)
if [ -z "$GITIGNORE" ]; then
  emit FAIL ".gitignore" "EMPTY OR MISSING"
else
  case "$LANG" in
    Go)
      if echo "$GITIGNORE" | grep -qE "(^|/)\*\.exe$|vendor/"; then
        emit PASS ".gitignore Go-appropriate"
      else
        emit WARN ".gitignore present but missing Go patterns (*.exe, vendor/)"
      fi
      ;;
    Python)
      if echo "$GITIGNORE" | grep -qE "__pycache__|\.venv|\*\.pyc"; then
        emit PASS ".gitignore Python-appropriate"
      else
        emit WARN ".gitignore present but missing Python patterns (__pycache__, .venv, *.pyc)"
      fi
      ;;
    Rust)
      if echo "$GITIGNORE" | grep -qE "target/"; then
        emit PASS ".gitignore Rust-appropriate"
      else
        emit WARN ".gitignore present but missing Rust pattern (target/)"
      fi
      ;;
    TypeScript|JavaScript)
      if echo "$GITIGNORE" | grep -qE "node_modules|dist/"; then
        emit PASS ".gitignore JS/TS-appropriate"
      else
        emit WARN ".gitignore present but missing JS patterns (node_modules, dist/)"
      fi
      ;;
    *)
      emit PASS ".gitignore present (language=$LANG, generic check)"
      ;;
  esac
fi
echo

# ===========================================================================
# CHECK 5 — CHANGELOG.md Keep a Changelog format
# ===========================================================================
echo "[5] CHANGELOG.md Keep a Changelog format"
CHANGELOG=$(fetch_content CHANGELOG.md)
if [ -z "$CHANGELOG" ]; then
  emit FAIL "CHANGELOG.md content" "EMPTY OR MISSING"
else
  if echo "$CHANGELOG" | grep -qiE "keep a changelog|keepachangelog"; then
    if echo "$CHANGELOG" | grep -qE "^## \[Unreleased\]"; then
      emit PASS "CHANGELOG Keep-a-Changelog format with [Unreleased] section"
    else
      emit WARN "CHANGELOG references Keep-a-Changelog but missing [Unreleased] section"
    fi
  else
    emit WARN "CHANGELOG present but not in Keep-a-Changelog format" "($(echo "$CHANGELOG" | head -1 | cut -c1-50))"
  fi
fi
echo

# ===========================================================================
# CHECK 6 — CODEOWNERS team references
# ===========================================================================
echo "[6] CODEOWNERS team references"
CODEOWNERS=$(fetch_content .github/CODEOWNERS)
if [ -z "$CODEOWNERS" ]; then
  emit FAIL ".github/CODEOWNERS content" "EMPTY OR MISSING"
else
  if echo "$CODEOWNERS" | grep -qE "@thornveil-ai/engineering|@jeranaias"; then
    emit PASS "CODEOWNERS references engineering team or admin"
  else
    emit FAIL "CODEOWNERS missing engineering team or admin references"
  fi
fi
echo

# ===========================================================================
# CHECK 7 — label-sync.yml caller workflow
# ===========================================================================
echo "[7] label-sync.yml caller workflow"
LABEL_SYNC=$(fetch_content .github/workflows/label-sync.yml)
if [ -z "$LABEL_SYNC" ]; then
  emit FAIL "label-sync.yml" "EMPTY OR MISSING"
else
  if echo "$LABEL_SYNC" | grep -qE "thornveil-ai/\.github/\.github/workflows/label-sync\.yml@main"; then
    emit PASS "label-sync.yml references org reusable workflow"
  else
    emit FAIL "label-sync.yml present but doesn't reference org reusable"
  fi
fi
echo

# ===========================================================================
# CHECK 8 — CONTRIBUTING.md per-tier rules
# ===========================================================================
echo "[8] CONTRIBUTING.md per-tier rules"
CONTRIB_SHA=$(file_exists CONTRIBUTING.md)
case "$TIER" in
  1)
    if [ -n "$CONTRIB_SHA" ]; then
      CONTRIB=$(fetch_content CONTRIBUTING.md)
      if [ "$(echo "$CONTRIB" | wc -l)" -gt 10 ]; then
        emit PASS "CONTRIBUTING.md substantive (Tier 1 required)"
      else
        emit WARN "CONTRIBUTING.md present but thin (Tier 1 wants substantive)"
      fi
    else
      emit FAIL "CONTRIBUTING.md missing (Tier 1 required)"
    fi
    ;;
  2|3)
    if [ -n "$CONTRIB_SHA" ]; then
      emit WARN "CONTRIBUTING.md present (Tier 2/3 should omit; CODEOWNERS routes review)"
    else
      emit PASS "CONTRIBUTING.md absent (correct for Tier 2/3)"
    fi
    ;;
  companion)
    # Companions have minimal CONTRIBUTING; either present minimal or absent
    if [ -n "$CONTRIB_SHA" ]; then
      emit PASS "CONTRIBUTING.md present (companion)"
    else
      emit PASS "CONTRIBUTING.md absent (companion, acceptable)"
    fi
    ;;
esac
echo

# ===========================================================================
# CHECK 9 — Patent verbiage sweep
# ===========================================================================
echo "[9] Patent verbiage sweep (zero tolerance per policy)"
# Per task: regex /patent/i, /USPTO/, /pending application/i, /provisional/i,
# /THRN-?\d/, "Patent Pending", "patent-pending"
# EXCEPTION: keep "Federal Edition" labeling on Auspex
PATENT_REGEX='patent|USPTO|pending application|provisional|THRN-?[0-9]+|Patent Pending|patent-pending'
# Apache-2.0 LICENSE contains standard "Grant of Patent License" boilerplate — skip
# patent-sweep on LICENSE if it's a standard Apache-2.0 file.
PATENT_HITS=0
PATENT_DETAILS=""
for f in README.md LICENSE CHANGELOG.md NOTICE CONTRIBUTING.md SECURITY.md; do
  content=$(fetch_content "$f")
  if [ -n "$content" ]; then
    # Skip standard Apache-2.0 LICENSE — its "Grant of Patent License" section is normal
    if [ "$f" = "LICENSE" ] && echo "$content" | grep -q "Apache License" && echo "$content" | grep -q "Version 2.0"; then
      continue
    fi
    if [ "$REPO" = "auspex" ] || [ "$REPO" = "auspex-contact" ]; then
      # Exclude "Federal Edition" matches on Auspex
      hits=$(echo "$content" | grep -E -i "$PATENT_REGEX" | grep -vi "Federal Edition" | wc -l)
    else
      hits=$(echo "$content" | grep -E -i "$PATENT_REGEX" | wc -l)
    fi
    if [ "$hits" -gt 0 ]; then
      PATENT_HITS=$((PATENT_HITS + hits))
      PATENT_DETAILS="$PATENT_DETAILS $f($hits)"
    fi
  fi
done
# Also check docs/ if it exists
DOCS_LIST=$(gh api "repos/thornveil-ai/$REPO/contents/docs" --jq '.[].name' 2>/dev/null | grep -E '\.md$|\.txt$' | head -20)
for doc in $DOCS_LIST; do
  content=$(fetch_content "docs/$doc")
  if [ -n "$content" ]; then
    if [ "$REPO" = "auspex" ] || [ "$REPO" = "auspex-contact" ]; then
      hits=$(echo "$content" | grep -E -i "$PATENT_REGEX" | grep -vi "Federal Edition" | wc -l)
    else
      hits=$(echo "$content" | grep -E -i "$PATENT_REGEX" | wc -l)
    fi
    if [ "$hits" -gt 0 ]; then
      PATENT_HITS=$((PATENT_HITS + hits))
      PATENT_DETAILS="$PATENT_DETAILS docs/$doc($hits)"
    fi
  fi
done

if [ "$PATENT_HITS" = "0" ]; then
  emit PASS "patent verbiage sweep clean"
else
  emit FAIL "patent verbiage hits ($PATENT_HITS total)" "$PATENT_DETAILS"
fi
echo

# ===========================================================================
# CHECK 10 — GitHub settings consistency (skip for companions per task spec)
# ===========================================================================
if [ "$TIER" != "companion" ]; then
  echo "[10] GitHub settings consistency"
  WIKI=$(gh api "repos/thornveil-ai/$REPO" --jq '.has_wiki' 2>/dev/null)
  DISC=$(gh api "repos/thornveil-ai/$REPO" --jq '.has_discussions' 2>/dev/null)
  DEFAULT=$(gh api "repos/thornveil-ai/$REPO" --jq '.default_branch' 2>/dev/null)
  DESC_LEN=$(gh api "repos/thornveil-ai/$REPO" --jq '.description | if . == null then 0 else (. | length) end' 2>/dev/null)

  if [ "$WIKI" = "false" ]; then emit PASS "wikis disabled"; else emit FAIL "wikis still enabled"; fi
  if [ "$DISC" = "false" ]; then emit PASS "discussions disabled"; else emit WARN "discussions enabled (verify intentional)"; fi
  if [ "$DEFAULT" = "main" ]; then emit PASS "default branch = main"; else emit WARN "default branch = $DEFAULT"; fi
  if [ "$DESC_LEN" -gt 0 ] && [ "$DESC_LEN" -le 130 ]; then
    emit PASS "description present ($DESC_LEN chars)"
  elif [ "$DESC_LEN" -gt 130 ]; then
    emit WARN "description long ($DESC_LEN chars; aim for <=130)"
  else
    emit FAIL "description missing"
  fi

  # Topics
  TOPIC_COUNT=$(gh api "repos/thornveil-ai/$REPO/topics" --jq '.names | length' 2>/dev/null)
  if [ "$TOPIC_COUNT" -ge 3 ]; then
    emit PASS "topics seeded ($TOPIC_COUNT topics)"
  else
    emit WARN "topics thin or missing ($TOPIC_COUNT topics; standard wants thornveil + 2-3 domain tags)"
  fi
  echo
fi

# ===========================================================================
# CHECK 11 — README structure (REPO_STANDARDS.md §4)
# ===========================================================================
echo "[11] README structure (status callout, License section, footer)"
README=$(fetch_content README.md)
if [ -z "$README" ]; then
  emit FAIL "README.md content" "EMPTY OR MISSING"
else
  if echo "$README" | head -10 | grep -qE "^> \*\*.*\*\*"; then
    emit PASS "README status callout (line 1-10)"
  else
    emit FAIL "README missing standard status callout"
  fi
  if echo "$README" | grep -qE "^## License"; then
    emit PASS "README License section"
  else
    emit FAIL "README missing ## License section"
  fi
  if echo "$README" | grep -qiE "A Thornveil system"; then
    emit PASS "README Thornveil footer"
  else
    emit FAIL "README missing 'A Thornveil system' footer"
  fi
fi
echo

# ---------- Summary ----------
echo "=== Summary: thornveil-ai/$REPO (Tier $TIER) ==="
printf "  PASS: %d\n  FAIL: %d\n  WARN: %d\n" "$PASS" "$FAIL" "$WARN"

if [ "$FAIL" -gt 0 ]; then
  exit 1
else
  exit 0
fi
