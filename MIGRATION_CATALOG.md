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
- **Migration status:** Ready
- **IP:** Open source (Apache-2.0). NOTICE carves out Pyros and Mycelium as separate Thornveil works.
- **Customer-driven:** None (open-source community + commercial pilot inbound)
- **Org target:** `thornveil-ai/signet` (transfer from `jeranaias/signet`)
- **PyPI:** `signet-sign` v0.1.10.1
- **Docs:** `jeranaias.github.io/signet` → moves to `thornveil-ai.github.io/signet`

**Pre-publish blockers (5):**
- [ ] Update ~20 `jeranaias` URL refs across `pyproject.toml`, `mkdocs.yml`, `.github/FUNDING.yml`, `CODEOWNERS`, examples, CHANGELOG compare-URLs
- [ ] Re-issue PyPI Trusted Publisher binding for new owner/repo before next `v*` tag
- [ ] Update `pyproject.toml:14` author email to `jesse@thornveil.ai`
- [ ] Refresh or delete stale `SIGNET-CLAUDE-HANDOFF.txt`
- [ ] Decide `growth/` folder fate (keep in org repo or move to private launch-materials repo)

---

## 2. Alchemist

- **Tagline:** Algorithm-aware C-to-Rust translation. One command. Local LLM only.
- **Visibility:** Public — source (Apache-2.0)
- **Migration status:** Ready
- **IP:** Open source (Apache-2.0). No Meridian source embedded (verified — text-only references).
- **Customer-driven:** None
- **Org target:** `thornveil-ai/alchemist` (transfer from `jeranaias/alchemist`)
- **State note:** `PRODUCTION_READINESS.md` self-classifies as research prototype. README oversells.

**Pre-publish blockers (5):**
- [ ] Reconcile README vs `PRODUCTION_READINESS.md` (pick honest framing)
- [ ] Update test-count badge: 201 → 543
- [ ] Parameterize 7 hardcoded `100.109.172.64:8090` refs via `ALCHEMIST_ENDPOINT` env var
- [ ] Register `thornveil-alchemist` PyPI name (`alchemist` is squatted)
- [ ] Add `[project.urls]`, `authors`, `license` to `pyproject.toml`

---

## 3. Pyros

- **Tagline:** Self-sustaining inference engine for local LLMs. One binary, zero deps, 0.31 ms overhead.
- **Visibility:** Public — marketing (proprietary, no source)
- **Migration status:** Needs work (small commit + rename finish)
- **IP:** Proprietary / trade secret. Highest-IP subsystems: `darwinism/`, `allostasis/`+`cascade/`, `immune/`, `twin/`.
- **Customer-driven:** None directly (consumed by RigRun and Mycelium internally)
- **Org target:** `thornveil-ai/pyros` (transfer from `jeranaias/pyros`)

**Pre-publish blockers (5):**
- [ ] Commit 13 in-flight files (academic refs + SmoothLLM liability hedge + fuzz tests + provider shims)
- [ ] Finish prometheus→pyros rename: `layerset/defaults.go:8,24`, `e2e_test.go:25-26` env vars, `.gitignore:2-3`
- [ ] Rename local working directory `D:\projects\prometheus` → `D:\projects\pyros`
- [ ] Sweep `go.mod` and all imports `jeranaias/pyros` → `thornveil-ai/pyros` after transfer
- [ ] Cut `v0.2.1` tag + update `CHANGELOG.md` (stuck at v0.1.0)

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
- **Migration status:** Needs work (commit big WIP batch + IP scrub + PATENTS.md re-add)
- **IP:** Proprietary / trade secret. High-IP internals: `router.go` and `classify.go` (classification-gated routing), `spillage.go` (anti-bypass detection), `thinking.go` (thinking-depth control), `confidence/` package + `research/credibility.go` (multi-signal confidence).
- **Customer-driven:** Federal pipeline (ATO pending)
- **Org target:** `thornveil-ai/rigrun` (transfer from `jeranaias/rigrun`)

**Pre-publish blockers (6):**
- [ ] Commit 40 desktop WIP as feature batch (distribution wizard + Pyros integration + per-conversation research)
- [ ] `git clean -fd rigrun-desktop-live/ rigrun-desktop/shots/` (shadow checkout + Playwright screenshots)
- [ ] Decide on `playwright-smoke.mjs` and `demo-mount.tsx` (env-var or discard)
- [ ] Scrub 8 hardcoded `100.109.172.64` refs in WIP — env-var via `process.env.RIGRUN_BACKEND`
- [ ] Decide go-module path: keep `github.com/jeranaias/rigrun-tui` or sweep to `thornveil-ai/rigrun/go-server`

---

## 6. HawkStack

- **Tagline:** Compute-aware neural architecture topology theory + perception backbone family.
- **Visibility:** Public — marketing for paper + benchmark page; private for source.
- **Migration status:** Needs work (3-repo consolidation with `git filter-repo`)
- **IP:** Proprietary / trade secret. High-IP internals: `hawkstack/backbone/wem*.py` (backbone family), `hawkstack/training/sgdr.py` + `augment.py` (training recipe), `cli/ladder.py` (calibration table).
- **Customer-driven:** None directly (research)
- **Org target:** `thornveil-ai/hawkstack` (transfer from `jeranaias/hawkstack` + subtree-merge `jeranaias/thermalhawk` → `thermalhawk/`)
- **Canonical-thermal decision:** WEM is canonical. DCNv3 demotes to `thermalhawk/legacy_dcnv3/`.

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
- **Migration status:** Already on org (private side); needs cleanup
- **IP:** Proprietary / trade secret. `THORNVEIL-CONFIDENTIAL.md` flags ~11 Phase 10 crates explicitly.
- **Customer-driven:** Vanguard (Australian USV builder, partner)
- **Org target:** `thornveil-ai/meridian` (already exists, private)

**Pre-publish blockers (7):**
- [ ] `git pull --ff-only` first — local is 1 commit behind origin (Step 9.12)
- [ ] Reconcile `bin/meridian-stm32/src/main.rs` local vs origin modifications
- [ ] Commit 17 uncommitted as tank-test-prep batch
- [ ] Fix `public` remote URL from `jeranaias/meridian` to `jeranaias/meridian-core`
- [ ] Delete `vanguard` legacy remote
- [ ] `git rm --cached vanguard_github_repo.zip` (stale 45 KB snapshot)
- [ ] Scrub 13 hardcoded tailnet IPs (`100.72.16.72`, `100.113.149.38`) — env-var-ize
- [ ] Update README to add "Partner Context" section (currently zero mention of Vanguard/Tristan)
- [ ] Update STATUS.md banner (Phase 9.12 has lapped the "ESC mapping" gate)

---

## 8. Canopy

- **Tagline:** Multi-modal counter-UAS situational awareness. Replaces DragonOS/WarDragon.
- **Visibility:** Public — coming soon (private until past Phase 0)
- **Migration status:** Needs work (private push is ready; public requires closing README/reality gap)
- **IP:** Eventually AGPL-3.0 (currently kept private until product matures).
- **Customer-driven:** None yet
- **Org target:** `thornveil-ai/canopy` (transfer from `jeranaias/canopy`)
- **Reality check:** Mesh package exists but `cmd/canopyd/main.go` never instantiates it. Decide/classify packages unwired. ML classifiers return `TODO: ONNX Runtime inference`. `make build` will fail (Makefile builds 3 binaries from empty source dirs).

**Pre-publish blockers (5):**
- [ ] Fix Makefile to only build `canopyd`
- [ ] Soften README to match Phase 0 reality OR build out the unwired layers
- [ ] Rewrite "Mycelium-adapted mesh" README language (verified zero Mycelium imports — phrasing is misleading)
- [ ] Update `go.mod` from `github.com/thornveil/canopy` to `github.com/thornveil-ai/canopy`
- [ ] Decide LICENSE posture (keep AGPL-3.0 for eventual public release, or temporarily strip for private development)

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
| 5 | Meridian | Already on org | Cleanup + remote URL fix. |
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
