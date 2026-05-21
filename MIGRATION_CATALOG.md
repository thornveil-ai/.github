# Thornveil Migration Catalog

Canonical migration reference for the 10 systems consolidating onto `github.com/thornveil-ai`. This document is the source of truth for per-system metadata that is NOT yet encoded as GitHub Project fields (visibility tier, patent status, customer-driven, pre-publish blockers). When a system transfers in, the maintainer reads the system's section here and files the pre-migration blockers as issues in the destination repo.

**Authoritative path:** `thornveil-ai/.github/MIGRATION_CATALOG.md` (this file, repo root, not the `.github/` subdir).

**Update rule:** when a blocker closes or a system's posture changes, edit this file in place. Do not duplicate metadata into Project fields until you have >20 issues to filter on.

**Quality bar:** Every repo on the org meets [REPO_STANDARDS.md](REPO_STANDARDS.md). When something here conflicts with that document, that document wins.

---

## Polish status (Step 6 — 2026-05-21)

**10 of 10 systems migrated to thornveil-ai org. 9 of 10 polished to REPO_STANDARDS.md spec.** Auspex polish is a queued follow-up (Tier-3 minimal posture; PR-only main blocks immediate edits while other work is in-flight).

| System | README structure | Settings | Patent scrub |
|---|---|---|---|
| signet | ✓ all green | desc / topics / wiki off | n/a (Apache-2.0) |
| alchemist | ✓ all green | desc / topics / wiki off / homepage set | n/a (Apache-2.0) |
| pyros | ✓ all green | desc / topics / wiki off / homepage set + CHANGELOG back-filled v0.2.0+v0.2.1 | clean |
| canopy | ✓ all green | desc / topics / wiki off / homepage set + CHANGELOG created | clean |
| meridian | ✓ all green | desc / topics / wiki off | clean |
| mycelium | ✓ all green | desc / topics / wiki off / homepage set | scrubbed (3 refs in README, kept NOTICE pointer) |
| navigator | ✓ all green | desc / topics / wiki off / homepage set | `patent_drafter` agent name preserved (legitimate tool name, not patent marker) |
| rigrun | ✓ all green | desc / topics / wiki off | scrubbed (badge, nav, body, 64/004,056 + 3 other app numbers, "⚡ Patent Pending" markers, ## Patents section, footer) |
| hawkstack | ✓ all green | desc / topics / wiki off / homepage set | scrubbed (THRN-2026-024, THRN-2026-026 in License) |
| **auspex** | Partial — informal callout present, missing standard `## License` section + footer (queued PR) | wiki off / topics seeded (6) / desc 91 chars | clean (no patent refs in README) |

For the 9 polished systems, "all green" means: status callout, badge row, Quick Start, Architecture (with Mermaid diagram), License section, "A Thornveil system" footer.

**Auspex polish follow-up (Tier 3 — minimal posture):** Per REPO_STANDARDS.md Section 5/Tier 3, Auspex doesn't need architecture diagrams or full standard treatment. Required minimum additions:
- Standard-format status callout: `> **Private. Export-controlled (EAR ECCN 4D004). v0.6.0-rc1 — federal pipeline.**`
- `## License` section referencing LICENSE + EXPORT_CONTROLS.md + auspex-clearance team gate
- "A Thornveil system" footer

Holding the PR until `thornveil-ai/auspex#1` (URL straggler sweep) lands and no other Claude is mid-flight in the repo.

**UI follow-ups (cannot be done via API):**
- Pin top 6 repos on org profile: `signet, mycelium, rigrun, pyros, hawkstack, alchemist` — https://github.com/organizations/thornveil-ai/settings/profile
- Enable `cosign-release.yml` + `sbom.yml` as org-required workflows once 5+ repos have CI workflows wired — https://github.com/organizations/thornveil-ai/settings/actions
- Per-repo Settings → Code security → Dependabot + CodeQL audit (may already be on by inheritance; UI verifies)
- **Auspex Settings → Actions** → "Fork pull request workflows from outside collaborators" → "Require approval for all outside collaborators" (ECCN 4D004 OPSEC) — https://github.com/thornveil-ai/auspex/settings/actions
- **Auspex auspex-clearance team membership** — currently 0 members; populate per-engagement as federal customers need read access

---

## Visibility tiers

| Tier | Meaning |
|---|---|
| Public — source | Full source visible. Apache-2.0 or AGPL-3.0. Issues/PRs welcome from outside. |
| Public — marketing | Marketing page, demo video, request-access CTA. No source. |
| Public — coming soon | Visible on org as a private repo; no public surface until product gap closes. |
| Public — federal-gated | Behind contact form; ECCN/dual-use review required for any external access. |
| Internal only | Org-private, no public surface ever. |

## Migration-readiness pills

| Pill | Meaning |
|---|---|
| Ready | Cosmetic fixes only during transfer. <1 hour of work. |
| Needs work | 1-4 hours of cleanup/commits/scrubbing before transfer. |
| Gated | Requires external sign-off (legal, export, partner) before transfer. |
| Already on org | Repo lives at `thornveil-ai/<name>` already. |
| Migrated | Transfer complete and verified. |

---

## 1. Signet

- **Tagline:** Capability-based safety gates for LLM agents. The model proposes; signet authorizes.
- **Visibility:** Public — source (Apache-2.0)
- **Migration status:** Migrated (2026-05-20 — Step 3 cascade, system #1)
- **IP:** Open source (Apache-2.0). NOTICE carves out Pyros and Mycelium as separate Thornveil works.
- **Customer-driven:** None (open-source community + commercial pilot inbound)
- **Org target:** `thornveil-ai/signet` (transferred from `jeranaias/signet`)
- **PyPI:** `signet-sign` v0.1.10.1
- **Docs site:** `thornveil-ai.github.io/signet` (Pages config + redeploy required from this org)

**Pre-publish blockers (5):**
- [x] Update ~20 `jeranaias` URL refs across `pyproject.toml`, `mkdocs.yml`, `.github/FUNDING.yml`, `CODEOWNERS`, examples, CHANGELOG compare-URLs (commit fa796f2, 18 files)
- [ ] **OPEN — REQUIRED BEFORE NEXT v* TAG:** Re-issue PyPI Trusted Publisher binding for `thornveil-ai/signet` at https://pypi.org/manage/account/publishing/ — without this, OIDC exchange fails at the next release
- [x] Update `pyproject.toml:14` author email to `jesse@thornveil.ai` (commit fa796f2)
- [x] Delete stale `SIGNET-CLAUDE-HANDOFF.txt` (commit fa796f2)
- [ ] `growth/` folder — kept in repo for now; revisit after Show HN run

**Post-transfer state (commit 5e77fe5):**
- [x] CODEOWNERS (`thornveil-ai/engineering` default, `@thornveil-ai/security` for core/audit/checks, `@jeranaias` admin for publish.yml and PyPI-binding-sensitive paths)
- [x] Branch protection: tier1-public-oss (classic) — PR + 1 review + CODEOWNERS + linear history, no required_signatures (public OSS doesn't require contributor signing)
- [x] Label-sync caller workflow active (`.github/workflows/label-sync.yml`), verified — 38 labels propagated
- [ ] Repo pinned on org profile (TODO when pin slot prioritized)
- [ ] Dependabot + secret scanning + CodeQL enabled in repo Settings (TODO via UI)
- [ ] System's GitHub Project default-repo updated from `meridian` to `signet` (TODO via UI)

---

## 2. Alchemist

- **Tagline:** Algorithm-aware C-to-Rust translation. One command. Local LLM only.
- **Visibility:** Public — source (Apache-2.0)
- **Migration status:** Migrated (2026-05-20 — Step 3 cascade, system #2)
- **IP:** Open source (Apache-2.0). No Meridian source embedded (verified — text-only references).
- **Customer-driven:** None
- **Org target:** `thornveil-ai/alchemist` (transferred from `jeranaias/alchemist`)
- **State note:** Honest framing applied — status badge now "research-prototype" linking to PRODUCTION_READINESS.md

**Pre-publish blockers (5):**
- [x] README softened: status badge "active" -> "research-prototype" linking to PRODUCTION_READINESS.md (commit 38d0395)
- [x] Test-count badge: 201 -> 543 (commit 38d0395)
- [x] Endpoint scrub: `100.109.172.64:8090` -> `http://localhost:8090/v1` default + `ALCHEMIST_ENDPOINT` env var override in config.py, client.py, cli.py; docs use `your-llm-host:8090` placeholder. Left `tests/test_scrubber.py:215` alone (redaction-test fixture).
- [x] PyPI dist name changed to `thornveil-alchemist` in pyproject.toml
- [x] Added `authors`, `license = Apache-2.0`, `readme`, `[project.urls]` (homepage/repository/issues) to pyproject.toml

**Post-transfer state (commit 5b8bb8a):**
- [x] CODEOWNERS landed (engineering default, security on anti_stub/scrubber, agents on LLM client, admin on pyproject/workflows)
- [x] Branch protection: tier1-public-oss applied (enforce_admins=false, code-owner reviews, linear history)
- [x] Label-sync caller workflow active — 38 labels propagated, verified
- [x] Fix: untracked accidentally-committed `subjects/zlib` gitlink (commit 6cea337)
- [ ] Register `thornveil-alchemist` on PyPI before publishing first release (UI: https://pypi.org/account/register/)
- [ ] Pin on org profile, Dependabot+secret-scan+CodeQL enable, Project default-repo update (UI)

---

## 3. Pyros

- **Tagline:** Self-sustaining inference engine for local LLMs. One binary, zero deps, 0.31 ms overhead.
- **Visibility:** Public — marketing (proprietary, no source)
- **Migration status:** Migrated (2026-05-20 — Step 3 cascade, system #3)
- **IP:** Proprietary / trade secret. Highest-IP subsystems: `darwinism/`, `allostasis/`+`cascade/`, `immune/`, `twin/`.
- **Customer-driven:** None directly (consumed by RigRun and Mycelium internally)
- **Org target:** `thornveil-ai/pyros` (transferred from `jeranaias/pyros`)
- **Default branch:** `master` (kept as-is per repo convention)

**Pre-publish blockers (5):**
- [x] Commit 13 in-flight files (combined into one commit 0d27865 — docs polish + SmoothLLM hedge + fuzz tests + provider shims + rename in one batch for efficiency)
- [x] Finish prometheus→pyros rename: `layerset/defaults.go:8,24`, `e2e_test.go:25-26` env vars, `.gitignore:2-3` (commit 0d27865)
- [ ] Rename local working directory `D:\projects\prometheus` → `D:\projects\pyros` (deferred — cosmetic only)
- [x] Sweep `go.mod` and all imports `jeranaias/pyros` → `thornveil-ai/pyros` post-transfer (commit 7a66bea: 73 files swept; commit 89508b9: fix CONTRIBUTING.md + docs/MODEL_CARD.md stragglers)
- [x] Cut `v0.2.1` tag (CHANGELOG update deferred for follow-up — tag landed)

**Post-transfer state:**
- [x] CODEOWNERS landed (agents team on subsystems, admin on darwinism/allostasis/cascade/immune/twin highest-IP files)
- [x] Branch protection: tier2 rulesets — strict (id=16677633) + process (id=16677634) — signed-commits required no bypass, PR/linear-history admin-bypassable
- [x] Label-sync caller workflow active — 38 labels propagated, verified
- [ ] Pin on org profile (TODO), CodeQL/secret-scan enable (UI), Project default-repo update (UI)
- [ ] CHANGELOG.md update (stuck at v0.1.0 — needs v0.2.0 + v0.2.1 entries written)

---

## 4. Mycelium

- **Tagline:** Distributed AI mesh. Substitute-on-failure inference across heterogeneous nodes.
- **Visibility:** Public — marketing (proprietary, no source; SOCPAC deploying this month)
- **Migration status:** Migrated (2026-05-20 — Step 5 heavy tier, system #1)
- **IP:** Proprietary / trade secret. High-IP internals: `internal/mesh/expert.go`, `expert_proxy.go`, `coordinator.go` (expert routing); `internal/mesh/style.go` (cross-model normalization); `internal/mesh/poi.go` (verification layer).
- **Customer-driven:** USSOCOM/SOCPAC (active deployment, ships this month)
- **Org target:** `thornveil-ai/mycelium` (transferred from `jeranaias/mycelium`)
- **Default branch:** `main`
- **v1.0.0 tag:** PRESERVED — points at `f9b96df` (signed)

**Pre-publish blockers (12):**
- [x] **`git pull --ff-only` first** — pulled 134 files / 5920 insertions, v1.0.0 tag now local
- [x] Reconcile 5 uncommitted — local stash was REDUNDANT (pulled HEAD already had MESH_MODE/FALLBACK_CONFIG/_health_poll_loop from commit a8fe0ea). Stash dropped.
- [x] Delete stale `HANDOFF.md` (commit 039fd29)
- [x] SECURITY-AUDIT.md banner added — explains pre-v1.0.0 vintage + points at remediation commits (cd599fc mTLS, 7498cc2 HMAC audit log, 03e83f7 mDNS) — commit 858713d
- [x] Remove `node/python/bin/backup.sh` (commit 039fd29)
- [ ] **REFRAMED — DEFERRED:** Catalog originally said "scrub RigRun brand-bleed across 30+ files." Survey revealed RigRun isn't brand-bleed in Mycelium — `node/go-server/` IS the SHARED BACKEND that powers both Mycelium mesh nodes AND the RigRun chat app. `RIGRUN_*` env vars, `.rigrun/` paths, `/opt/rigrun/` config defaults, and `cmd/installer/*` are load-bearing infrastructure. Aggressive scrubbing would break deployments. cmd/serve/main.go:4 comment updated to acknowledge the shared-backend reality (commit 039fd29); deeper Mycelium/RigRun separation is a future architectural refactor, not migration prep.
- [x] cmd/serve/main.go:4 comment now says "Mycelium / RigRun shared HTTP API server" (commit 039fd29)
- [ ] `internal/research/testdata_report.tex` — file no longer present (was caught in dropped stash; never committed)
- [x] **CATALOG AUDIT BUG:** No `.exe` binaries are actually tracked in git. The 5 .exe files on disk are dev-build artifacts, already covered by `*.exe` in `.gitignore`. No filter-repo needed.
- [x] Pre-transfer visibility confirmed PRIVATE
- [ ] R2I (Right to Integrate) README language (`d35b4f6`) — pulled in, left as-is. Brand-posture decision deferred.
- [ ] Export-controls re-review for `tak.go`/`tactical.go` post-transfer — TODO when legal cadence requires.

**Post-transfer state (commits a3e9213):**
- [x] CODEOWNERS — admin review on expert.go/expert_proxy.go/coordinator.go/style.go/poi.go (the patent-claim implementations)
- [x] Branch protection: tier2 rulesets — strict (id=16678728) + process (id=16678729)
- [x] Label-sync caller workflow active — 38 labels propagated
- [x] v1.0.0 + v1.0-standalone tags survived transfer
- [ ] Pin on org profile, Dependabot/CodeQL UI toggles (TODO)

---

## 5. RigRun

- **Tagline:** Professional AI chat. Your AI. Your hardware. Your rules.
- **Visibility:** Public — marketing (proprietary, no source; IL5 controls implemented)
- **Migration status:** Migrated (2026-05-20 — Step 4 medium tier, system #1)
- **IP:** Proprietary / trade secret. High-IP internals: `router.go` and `classify.go` (classification-gated routing), `spillage.go` (anti-bypass detection), `thinking.go` (thinking-depth control), `confidence/` package + `research/credibility.go` (multi-signal confidence).
- **Customer-driven:** Federal pipeline (ATO pending)
- **Org target:** `thornveil-ai/rigrun` (transferred from `jeranaias/rigrun`)
- **Default branch:** `master`

**Pre-publish blockers (5):**
- [x] Commit 40 desktop WIP as feature batch (commit 4ce307b: 37 files / 3375 insertions — distribution wizard + Pyros engine integration + per-conversation research snapshots, in 3 sub-clusters)
- [x] Delete `rigrun-desktop-live/` shadow checkout + `rigrun-desktop/shots/` Playwright screenshots
- [x] `demo-mount.tsx` deleted (temp); `playwright-smoke.mjs` env-var-ized (MYCELIUM_BASE || RIGRUN_BACKEND || placeholder)
- [x] Scrub hardcoded 100.109.172.64 in DISTRIBUTION_ROADMAP.md, playwright-smoke.mjs, extract-cert-pins.mjs (replaced with `your-rigrun-host.example`)
- [x] Go module path kept as `github.com/jeranaias/rigrun-tui` per recommendation — Go modules don't require path-matches-repo

**Post-transfer state (commit 937c8de):**
- [x] CODEOWNERS landed — admin review required on patent-trade-secret subsystems (router_v2, classify, thinking, spillage, confidence)
- [x] Branch protection: tier2 rulesets — strict (id=16678047) + process (id=16678048)
- [x] Label-sync caller workflow active — 38 labels propagated
- [ ] Repo Settings: Dependabot/secret-scan/CodeQL (UI), Project default-repo update (UI), pin on org profile (UI when sequenced)

---

## 6. HawkStack

- **Tagline:** Compute-aware neural architecture topology theory + perception backbone family.
- **Visibility:** Public — marketing for paper + benchmark page; private for source.
- **Migration status:** Migrated (2026-05-20 — Step 4 medium tier, system #2 — three-repo consolidation complete)
- **IP:** Proprietary / trade secret. High-IP internals: `hawkstack/backbone/wem*.py` (backbone family), `hawkstack/training/sgdr.py` + `augment.py` (training recipe), `cli/ladder.py` (calibration table).
- **Customer-driven:** None directly (research)
- **Org target:** `thornveil-ai/hawkstack` (transferred from `jeranaias/hawkstack` + subtree-merged ThermalHawk standalone into `thermalhawk/legacy_dcnv3/`)
- **Default branch:** `master`
- **Canonical-thermal decision (executed):** WEM is canonical at `hawkstack/models/thermalhawk.py`. DCNv3 demoted to `thermalhawk/legacy_dcnv3/` with full 19-commit history preserved.

**Migration milestones:**
- [x] Phase 1: HawkStack source repo cleanup — 3 cluster commits (da74424 feat NWD/RGBHawk wire-in, 2142d34 improve sgdr/TAL, e0cbb6a docs paper v10) + legacy v1 scaffold delete (b2d4fa6: 10 dirs, 20,673 deletions) + tag v0.3.0-pre-consolidate
- [x] Phase 2: ThermalHawk standalone cleanup — socom_submission moved to `D:/projects/_archive/`, 828 MB regenerable artifacts discarded, paper reviews + framediff committed (8d0e402), stale `nav/sprint-*` remote branch deleted, tag v-final-standalone
- [x] Phase 3: `git filter-repo --to-subdirectory-filter thermalhawk` on scratch clone (`/d/projects/_scratch/thermalhawk-rewritten/`), 19 commits rewritten under `thermalhawk/` prefix in 3.45s
- [x] Phase 4: `git merge --allow-unrelated-histories` thermalhawk-rewritten → hawkstack (4591651), DCNv3 demote (6bf46bf moves 200 files into `legacy_dcnv3/`), GH200 IP scrub to `<gh200>` placeholders (d58e045), .gitignore consolidation (7f49b74), tag v0.4.0-monorepo
- [x] Phase 5: Transfer to `thornveil-ai/hawkstack`; CODEOWNERS + label-sync caller (3d5e4d8); tier2 rulesets (strict id=16678401, process id=16678402); 38 labels propagated

**Verification:**
- Total commits in monorepo: **72** (53 hawkstack original + 19 thermalhawk standalone, all reachable)
- ThermalHawk standalone history reachable via merge second-parent: `git log 4591651^2` shows all 19 commits
- v-final-standalone tag points to a real ThermalHawk commit (SSH-signed)
- 200 files now under `thermalhawk/legacy_dcnv3/`; `thermalhawk/` top-level holds only `README.md` (two-lineage doc) + `legacy_dcnv3/` + `checkpoints/`

**Open follow-ups (UI-only):**
- Archive `jeranaias/thermalhawk` with redirect README pointing to `thornveil-ai/hawkstack/tree/master/thermalhawk` (redirect README content prepared at `/tmp/thermalhawk-redirect/README.md`)
- Archive `jeranaias/rgbhawk` (already a deprecate-redirect shell — just flip archive flag)
- DroneBane README submodule reference update: was `git clone --recurse-submodules https://github.com/jeranaias/dronebane.git` — verify auto-redirect handles it or update to point at `thornveil-ai/hawkstack/tree/master/thermalhawk`

**Pre-publish blockers (10):**
- [ ] Commit HawkStack 31 WIP files in 3 clusters (code+RGBHawk wire-in, sister dir, paper v10)
- [ ] Delete HawkStack legacy scaffolds at repo root: `core/`, `cellhawk/`, `depthhawk/`, `sentryhawk/`, `wildhawk/`, `forgehawk/`, `tidalhawk/`, `ecg/`, `ablation/`, `examples/`
- [ ] Commit ThermalHawk paper reviews + nano.tex + framediff
- [ ] Move `D:/projects/thermalhawk/socom_submission/` OUT to `D:/projects/_archive/socom-esof-2026-thermalhawk/`
- [ ] Discard 828 MB untracked artifacts in thermalhawk `data/` (regenerable)
- [ ] Delete stale remote branch `origin/nav/sprint-202603270546-20260327-0546` on thermalhawk
- [ ] `git filter-repo --to-subdirectory-filter thermalhawk` on scratch clone of standalone
- [ ] `git merge --allow-unrelated-histories` thermalhawk into hawkstack
- [ ] Demote DCNv3 source to `thermalhawk/legacy_dcnv3/` per canonical-WEM decision
- [ ] Scrub 13 files referencing `192.222.50.116` / `192.222.50.59` / `nahawi` (GH200 fleet) to `<gh200>` placeholder

---

## 7. Meridian

- **Tagline:** Memory-safe Rust autopilot for STM32 H7/F4/F7. ArduPilot/PX4 alternative.
- **Visibility:** Dual track — `jeranaias/meridian-core` public OSS + `thornveil-ai/meridian` private Thornveil hardening
- **Migration status:** Migrated (2026-05-20 — Step 2 canary)
- **IP:** Proprietary / trade secret. `THORNVEIL-CONFIDENTIAL.md` flags ~11 Phase 10 crates explicitly.
- **Customer-driven:** Vanguard (Australian USV builder, partner)
- **Org target:** `thornveil-ai/meridian` (already exists, private)

**Pre-publish blockers (7):**
- [x] `git pull --ff-only` first — local already in sync at Step 2 time
- [ ] Reconcile `bin/meridian-stm32/src/main.rs` local vs origin modifications (deferred — non-blocking, working copy committed as-is)
- [x] Commit 17 uncommitted as tank-test-prep batch (commit 992b7d9)
- [x] Fix `public` remote URL from `jeranaias/meridian` to `jeranaias/meridian-core`
- [x] Delete `vanguard` legacy remote
- [x] `git rm --cached vanguard_github_repo.zip` (stale 45 KB snapshot)
- [ ] Scrub 13 hardcoded tailnet IPs (`100.72.16.72`, `100.113.149.38`) — env-var-ize (deferred — private repo, tailnet-only IPs, not a data leak; do as follow-up)
- [ ] Update README to add "Partner Context" section (deferred — follow-up)
- [ ] Update STATUS.md banner (Phase 9.12 has lapped the "ESC mapping" gate)

---

## 8. Canopy

- **Tagline:** Multi-modal counter-UAS situational awareness. Replaces DragonOS/WarDragon.
- **Visibility:** Public — coming soon (private until past Phase 0)
- **Migration status:** Migrated (2026-05-20 — Step 3 cascade, system #4)
- **IP:** Eventually AGPL-3.0 (currently kept private until product matures).
- **Customer-driven:** None yet
- **Org target:** `thornveil-ai/canopy` (transferred from `jeranaias/canopy`)
- **Default branch:** `master`
- **Reality check:** Mesh package exists but `cmd/canopyd/main.go` never instantiates it. Decide/classify packages unwired. ML classifiers return `TODO: ONNX Runtime inference`. README now states this honestly.

**Pre-publish blockers (5):**
- [x] Fix Makefile to only build `canopyd` — canopy-cli + canopy-sim targets commented out as TODO (commit 2964b21)
- [x] Soften README to Phase 0 reality — new "Status" callout, full Implementation Status table per layer (commit 2964b21)
- [x] Rewrite "Mycelium-adapted mesh" — replaced with "mDNS-based discovery (independent implementation)" + verified zero Mycelium imports in source
- [x] `go.mod`: `github.com/thornveil/canopy` → `github.com/thornveil-ai/canopy` + sweep across .go internal imports
- [x] LICENSE: AGPL-3.0 retained in repo, README notes it activates on public distribution

**Post-transfer state:**
- [x] CODEOWNERS landed
- [x] Branch protection: tier2 rulesets — strict (id=16677703) + process (id=16677704)
- [x] Label-sync caller workflow active — 38 labels propagated, verified
- [ ] Pin on org profile: NO (Phase 0 — defer until Phase 1+)
- [ ] When ready for public: flip repo visibility to public, AGPL-3.0 activates automatically

---

## 9. Auspex

- **Tagline:** AI red team gated by Signet. Federal/IL5-fit autonomous offensive security.
- **Visibility:** Public — federal-gated (default posture: hidden from public site entirely)
- **Migration status:** Migrated (2026-05-21 — Step 5 heavy tier, system #3 — pushed to fresh org repo, bypassed seat-limit transfer block). New home: `thornveil-ai/auspex`. Old `jeranaias/auspex` left in place as GitHub-auto-redirect target — do NOT archive or delete. Method: created `thornveil-ai/auspex` empty via `gh api orgs/thornveil-ai/repos` (new-repo CREATE is unaffected by the seat limit), pushed cleaned-history main from local clone, pushed all 7 tags, swapped `origin` to thornveil-ai and renamed old `origin` → `jeranaias-old`. Commit `02e8b90` (CODEOWNERS + label-sync caller) landed on new main; tier3-auspex.json branch protection + required_signatures applied; label sync ran clean (38 labels). No commits lost — full history preserved.
- **IP:** Proprietary. **Export-controlled: EAR ECCN 4D004 "intrusion software" with Wassenaar implications** per `EXPORT_CONTROLS.md`.

**What's done (on `jeranaias/auspex`, ready for transfer):**
- [x] `.gitignore` tightened: `demos/**/*.{hex,hmac.key}` + `demos/**/chain.jsonl` patterns
- [x] **Two filter-repo passes** stripped 38 sensitive lab artifacts from history: 10 `eng-*.hex` HMAC keys (v0.4-goad + v0.4-ad eng dirs) + 18 `chain.jsonl` files (CTF flags + intentional weak passwords) + 10 more across `demos/v0.5-recon-coverage/*/chain/*` paths. 253 commits remain on `main` (was 462 — filter-repo collapsed 209 commits during rewrite); HEAD `c23dffa` is signed.
- [x] Go module path swept: `github.com/jeranaias/auspex` → `github.com/thornveil-ai/auspex` across all .go files + go.mod
- [x] README sister-project links updated: signet/mycelium/rigrun (incl. `jeranaias.github.io/signet` → `thornveil-ai.github.io/signet`)
- [x] `.mailmap` consolidates 3 identities → `jesse@thornveil.ai`
- [x] Force-pushed clean history to `jeranaias/auspex/main` (verified: eng-* dirs now have only README.md + audit-verify.txt, no .hex or chain.jsonl in remote)
- [x] CODEOWNERS + label-sync caller pushed to `thornveil-ai/auspex/main` as commit `02e8b90` (2026-05-21). Equivalent to the staged `47d9f06` at `/c/Users/jesse/AppData/Local/Temp/auspex_audit` — regenerated on live working tree because the audit-dir clone was abandoned.

**What's blocking (UI-side):**
- [x] Resolve seat-limit block — **bypassed**: created fresh `thornveil-ai/auspex` via API (new-repo CREATE is unaffected), pushed cleaned main + tags, swapped remotes. Old `jeranaias/auspex` remains as redirect.
- [x] Post-migration: tier3-auspex.json branch protection applied (`enforce_admins=true`, `require_code_owner_reviews=true`, `allow_force_pushes=false`, `restrictions.users=1` [jeranaias], `restrictions.teams=0` — auspex-clearance team exists on org but has no membership yet; non-fatal, populate per-engagement). Required signatures: `enabled=true`. Label sync: `completed-success`, 38 labels synced.
- [ ] UI-only: disable Actions on PRs from forks per ECCN 4D004 posture. Open `https://github.com/thornveil-ai/auspex/settings/actions` → "Fork pull request workflows from outside collaborators" → "Require approval for all outside collaborators" → Save. Cannot be set via API.

**Other pre-transfer state:**
- **Customer-driven:** Federal pipeline
- **Org target:** `thornveil-ai/auspex` (transfer from `jeranaias/auspex`)
- **Project access:** Admin-only. `auspex-clearance` team gets Read, populated per-engagement.

**Pre-publish blockers (6):**
- [ ] `git filter-repo` to strip 10 committed HMAC keys in `demos/v0.4-goad/eng-*/eng-*.hex`
- [ ] Strip or rotate `demos/v0.4-goad/eng-*/chain.jsonl` (contain CTF flags + intentional weak passwords)
- [ ] Tighten `.gitignore` to catch `*.hex` under `demos/`
- [ ] Update `go.mod` module path `jeranaias/auspex` → `thornveil-ai/auspex` + rewrite imports
- [ ] Update README sister-project links (signet/mycelium/rigrun → wherever those land)
- [ ] `.mailmap` to consolidate 3 commit identities (`jeranaias`, `Jesse Morgan`, `Jesse_Morgan`)

**Public-companion verdict:** NO public companion at this time. The combination of ECCN 4D004 + autonomous AD-takeover + procedural-knowledge stack means any substantive public artifact recreates the dual-use export problem from scratch.

---

## 10. Navigator (includes Agent Factory)

- **Tagline:** AI ops center for Thornveil. Internal infrastructure that runs the rest.
- **Visibility:** Internal only (no public version planned)
- **Migration status:** Migrated (2026-05-21 — Step 5 heavy tier, system #2)
- **IP:** Proprietary, internal-only. Conceptual overlap with Pyros (Go production) on adaptive subsystems.
- **Customer-driven:** Internal use only
- **Org target:** `thornveil-ai/navigator` (init-from-scratch on RigRun via SSH, then created + pushed)
- **Default branch:** `main`
- **Initial commit footprint:** 161 files

**Pre-publish blockers (8):**
- [x] `git init -b main` in `/opt/rigrun/navigator/` (no history to preserve)
- [x] Deleted 6 `.bak`/`.v3.bak`/`.v4.bak` files in `core/` (agent_runtime, cascade, daemon, executor)
- [x] Deleted bizarre Windows-path dirs at repo root: `C:\Users\jesse`, `C:\Users\jesse\Documents\Thornveil\Provisionals`, `D:\projects` (including `dronebane/hunter_modules` nested subdir caught in path)
- [x] Deleted `app.py.bak-20260328-1458` + `app.py.bak-maverick` + `.coverage`
- [x] `.gitignore` already covered `*.db` (catches 447 MB navigator.db) + `__pycache__/` + `.pytest_cache/` + `*.bak` — kept as-is
- [x] 9 agent JSONs copied from `~/.rigrun/agents/*.json` → `agents/` as repo content (self-contained repo)
- [x] **LICENSE rewritten** — was Apache-2.0 with patent notice (THRN-2026-018 through 023); user directive said patents off the repo surface + Navigator is internal-only. Replaced with proprietary "All rights reserved" Thornveil LLC license.
- [x] README documents Pyros (Go production) vs Navigator (Python research) dedup intent

**Post-transfer state (initial commit + commit 1358a4c):**
- [x] Repo created via `gh api -X POST orgs/thornveil-ai/repos` (seat issue does NOT affect new repo creation, only transfers)
- [x] Pushed from RigRun via `gh auth setup-git` configured locally there (RigRun has gh CLI auth as jeranaias)
- [x] CODEOWNERS landed — admin review on agent_factory.py, agent_runtime.py, top-IP subsystems
- [x] Branch protection: tier2 rulesets — strict (id=16715886) + process (id=16715890)
- [x] Label-sync caller workflow active — 38 labels propagated, verified

**Open follow-ups:**
- [ ] Future Pyros vs Navigator subsystem dedup refactor (architectural decision, not migration prep)

---

## Recommended transfer order

| Order | System | Tier | Why this position |
|---|---|---|---|
| 1 | Signet | Ready | Cleanest. Tests the transfer pipeline against a public Apache-2.0 repo. |
| 2 | Alchemist | Ready | Low IP risk. Confirms public-source flow. |
| 3 | Pyros | Needs work (small) | Small commit batch. No structural rework. |
| 4 | Canopy | Needs work (private posture) | Clean state for private push. Defer public until Phase 1+. |
| 5 | Meridian | Migrated | Cleanup + remote URL fix completed 2026-05-20. |
| 6 | RigRun | Needs work (medium) | One feature commit + IP scrub. Customer-facing readiness. |
| 7 | HawkStack | Needs work (large) | Three-repo consolidation. Requires `git filter-repo` discipline. |
| 8 | Mycelium | Needs work (large) | Pull-first. Reconcile WIP. Customer is live — high stakes. |
| 9 | Navigator | Needs work (init) | Fresh `git init`. Cruft cleanup. Last because least time-critical. |
| 10 | Auspex | Gated | OPSEC review required. Filter-repo for secrets. Move last so it lands when org practices are mature. |

---

## Cross-cutting work (touches multiple systems)

- **Hardcoded `100.109.172.64`** (RigRun Tailscale) appears in Alchemist (7), Meridian (3), RigRun WIP (8), Mycelium (deploy docs). Org-wide pattern: replace with env var.
- **Hardcoded `192.222.50.116` / `192.222.50.59`** (GH200) appears in ThermalHawk (13), HawkStack `model_notes`. Same env-var pattern.
- **`/home/exx`** paths appear in Mycelium `backup.sh`. Config-driven.
- **PyPI Trusted Publisher bindings** must be re-issued for Signet (and any future Alchemist publish) at the new org/repo before next `v*` tag.
- **`.mailmap`** at each repo to consolidate `jeranaias` / `Jesse Morgan` / `Jesse_Morgan` author identities.

---

## How to use this document

1. **Before a migration:** read this file's section for the system about to move. File its pre-publish blockers as issues IN the destination repo (after transfer). Do not duplicate blockers into Project fields.
2. **During migration:** check off blockers in this file as you close them. PR-comment-link the issue numbers as you go.
3. **After migration:** update the system's migration status pill to "Migrated" at the top of its section. Add a one-line note about anything that ended up surprising.
4. **Cross-system blockers** (the bullets in "Cross-cutting work" above): file once in the Security & Compliance project with a Linked Systems field listing the affected repos.

**This is the only canonical source for migration metadata.** Project fields exist only when the field has filtering value at >20 issues. Until then, this document is the answer.
