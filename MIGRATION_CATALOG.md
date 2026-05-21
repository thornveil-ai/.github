# Thornveil Migration Catalog

Canonical migration reference for the 10 systems consolidating onto `github.com/thornveil-ai`. This document is the source of truth for per-system metadata that is NOT yet encoded as GitHub Project fields (visibility tier, patent status, customer-driven, pre-publish blockers). When a system transfers in, the maintainer reads the system's section here and files the pre-migration blockers as issues in the destination repo.

**Authoritative path:** `thornveil-ai/.github/MIGRATION_CATALOG.md` (this file, repo root, not the `.github/` subdir).

**Update rule:** when a blocker closes or a system's posture changes, edit this file in place. Do not duplicate metadata into Project fields until you have >20 issues to filter on.

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
- **Migration status:** Needs work (pull-first + WIP reconcile + binary filter + brand cleanup)
- **IP:** Proprietary / trade secret. High-IP internals: `internal/mesh/expert.go`, `expert_proxy.go`, `coordinator.go` (expert routing); `internal/mesh/style.go` (cross-model normalization); `internal/mesh/poi.go` (verification layer).
- **Customer-driven:** USSOCOM/SOCPAC (active deployment, ships this month)
- **Org target:** `thornveil-ai/mycelium` (transfer from `jeranaias/mycelium`)

**Pre-publish blockers (12):**
- [ ] **`git pull --ff-only` first** — local is 13 commits behind, including v1.0.0 release tag
- [ ] Reconcile 5 uncommitted files against pulled `a8fe0ea` (3 are likely duplicate WIP)
- [ ] Rewrite or delete stale `HANDOFF.md` (claims mesh is dead; it's wired in)
- [ ] Update SECURITY-AUDIT.md banner after pull (3 Open findings likely closed)
- [ ] Remove `node/python/bin/backup.sh` — hardcodes RigRun-specific paths
- [ ] Scrub `scripts/mycelium-mesh-setup.sh:139`, `node/web/mesh_dashboard.py:24`, `deploy/README.md` SSH commands
- [ ] Update `cmd/serve/main.go:7` comment ("RigRun" → "Mycelium")
- [ ] Rebrand `internal/research/testdata_report.tex` from RigRun teal palette to Mycelium
- [ ] `git filter-repo` to drop 4 committed `.exe` binaries in `node/go-server/`
- [ ] Confirm new repo visibility is PRIVATE before transfer
- [ ] Decide on R2I (Right to Integrate) public-facing README language (`d35b4f6` on remote)
- [ ] Verify export-controls posture vs TAK/CoT integration files (`tak.go`, `tactical.go`)

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
- **Migration status:** Gated (filter-repo for committed secrets + OPSEC review before any external visibility)
- **IP:** Proprietary. **Export-controlled: EAR ECCN 4D004 "intrusion software" with Wassenaar implications** per `EXPORT_CONTROLS.md`.
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
- **Migration status:** Needs work (init from scratch — never been in git)
- **IP:** Proprietary, internal-only. Conceptual overlap with Pyros (Go production) on adaptive subsystems.
- **Customer-driven:** Internal use only
- **Org target:** `thornveil-ai/navigator` (init from scratch, mirror `/opt/rigrun/navigator/` wholesale)

**Pre-publish blockers (8):**
- [ ] `git init` in `/opt/rigrun/navigator/` (no history to preserve)
- [ ] Delete `.bak`/`.v3.bak`/`.v4.bak` files in `core/`
- [ ] Delete bizarre Windows-path dirs at repo root: `C:\Users\jesse`, `C:\Users\jesse\Documents\Thornveil\Provisionals`, `D:\projects`
- [ ] Delete `app.py.bak-20260328-1458`, `app.py.bak-maverick`
- [ ] Add `.gitignore`: `navigator.db` (467 MB SQLite), `__pycache__/`, `.pytest_cache/`, `.coverage`, `*.bak*`
- [ ] Decide 9 agent JSONs (`~/.rigrun/agents/*.json`) → pull into `navigator/agents/` as repo content or document as external config
- [ ] Add `LICENSE` (Proprietary, Thornveil LLC)
- [ ] Document Pyros (Go) vs Navigator (Python) deduplication intent in README

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
