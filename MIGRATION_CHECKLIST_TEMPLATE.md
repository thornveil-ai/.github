# Migration day checklist — `<SYSTEM_NAME>`

Clone this template into a GitHub issue at the start of each per-system migration. Replace `<SYSTEM_NAME>` and check items off as you go.

## Pre-transfer

- [ ] Read this system's section in `thornveil-ai/.github/MIGRATION_CATALOG.md`
- [ ] All pre-publish blockers from catalog are either closed locally or explicitly skipped with rationale recorded in this issue
- [ ] Local repo: `git status` clean, branches reconciled, stashes resolved
- [ ] Local repo: relevant `.bak` / shadow checkouts / build artifacts cleaned
- [ ] Hardcoded IPs scrubbed or env-var-ized (see catalog cross-cutting list)
- [ ] Migration script `migration-scripts/NN-<system>.sh` runs cleanly in `DRY_RUN=1` mode

## Transfer

- [ ] `gh api repos/jeranaias/<system>/transfer -f new_owner=thornveil-ai` executed (or via UI: Settings → Transfer ownership)
- [ ] Transfer confirmed in GitHub UI
- [ ] CI green on first push after transfer (if CI is wired)

## Post-transfer

- [ ] Default branch verified (`main` vs `master` — match repo convention)
- [ ] `CODEOWNERS` file added from `thornveil-buildout/codeowners/<system>-CODEOWNERS`
- [ ] Branch protection rules applied (per tier — Tier 1 / Tier 2 / Tier 3-auspex)
- [ ] Labels synced from `.github/labels.yml` (add this repo to the `label-sync.yml` matrix in the `.github` repo)
- [ ] System's GitHub Project default-repo updated from `meridian` to this repo
- [ ] Dependabot enabled (alerts on; security updates per system policy in the catalog)
- [ ] Secret scanning + push protection enabled
- [ ] CodeQL enabled (Tier 1 + Tier 2 if Go/Python)
- [ ] Required workflows wired up (cosign-release, SBOM as applicable)
- [ ] Repo pinned on org profile (if applicable — see catalog pin order)
- [ ] Update `MIGRATION_CATALOG.md`: change migration-status pill at top of this system's section to "Migrated"
- [ ] Migration & Onboarding Project: close this system's tracking issue
- [ ] `jeranaias/<system>` replaced with redirect README + archived via GitHub settings (if applicable)

## Notes

<!-- Anything surprising during this migration goes here. Will be useful for the next system. -->
