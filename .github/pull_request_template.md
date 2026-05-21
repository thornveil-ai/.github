## Summary

<!-- One or two sentences. What does this PR do and why? -->

## Related Issues

<!-- e.g. Closes #123, Refs #456 -->

## Type of Change

- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds capability)
- [ ] Breaking change (fix or feature that changes existing behavior)
- [ ] Documentation update
- [ ] Refactor / internal cleanup (no behavior change)
- [ ] CI / build / tooling

## How Has This Been Tested?

<!-- Describe the tests you ran. Include hardware, OS, and any non-default configuration. -->

- [ ] Tests added or updated
- [ ] Manual verification (describe above)
- [ ] Behavioral parity verified (if refactoring)

## Trade-Secret Review

<!-- Private repos only. Skip on public OSS (Signet, Alchemist, meridian-core). -->

- [ ] This PR does NOT touch a high-IP subsystem listed in MIGRATION_CATALOG.md for this system
- [ ] OR — this PR touches a high-IP subsystem AND has been reviewed by an admin (`@jeranaias` or designated)

## Security Considerations

<!-- If this PR touches authentication, cryptography, input parsing, network handling, or anything else security-sensitive, describe what you considered. If none, write "N/A". -->

## Engineering Principles

- [ ] No new C or CGO code (or if added, memory-safety justification provided above)
- [ ] If this is a release, cosign-signing workflow was run (`.github/workflows/release.yml`)
- [ ] No hardcoded customer IPs, paths, or names introduced

## Checklist

- [ ] I read [CONTRIBUTING.md](https://github.com/thornveil-ai/.github/blob/main/CONTRIBUTING.md)
- [ ] My code follows the project's style (gofmt, go vet, staticcheck clean for Go; ruff + mypy strict for Python)
- [ ] New and existing tests pass locally
- [ ] Documentation / CHANGELOG updated as needed
- [ ] Commits are signed off (`git commit -s`) per the DCO
- [ ] This PR introduces no new runtime dependencies (or the dependency is justified above)

## Notes for Reviewers

<!-- Anything else reviewers should know? Tricky logic, intentional trade-offs, follow-up work, etc. -->
