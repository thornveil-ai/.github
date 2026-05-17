# Contributing to Thornveil

Thanks for taking the time to contribute. Thornveil ships infrastructure that customers run in production, in regulated environments, and behind air-gaps. We hold contributions to a high bar — and we're glad to work with you to get yours across it.

## Before You Start

- **Read the [Code of Conduct](./CODE_OF_CONDUCT.md).** It applies to every interaction in this org.
- **Check existing issues and pull requests.** Someone may already be working on the same thing.
- **For non-trivial changes, open an issue first.** Describe the problem, the proposed approach, and why it belongs in Thornveil. This saves everyone time.

## Ways to Contribute

- **Report bugs.** Use the bug report template. Include reproduction steps, version, and environment.
- **Propose features.** Use the feature request template. Lead with the problem, not the solution.
- **Improve documentation.** Typos, clarifications, missing examples — all welcome.
- **Submit code.** See below.

## Development Workflow

1. **Fork** the repository and create a topic branch from `main`.
2. **Make your change.** Keep commits focused and well-described.
3. **Add tests.** Bug fixes need a regression test. Features need coverage.
4. **Run the full test suite locally** before pushing.
5. **Open a pull request** against `main` with a clear description of what changed and why.
6. **Be responsive** to review feedback. Reviews are how we keep the bar high.

## Code Standards

Thornveil products are written in **pure Go** unless there's a specific, documented reason otherwise.

- **No CGO** unless the maintainers explicitly approve it for that module.
- **No new runtime dependencies** without discussion. Vendored, audited, and pinned.
- **`gofmt` and `goimports` clean.** CI will reject unformatted code.
- **`go vet` and `staticcheck` clean.** No new warnings.
- **Tests required.** `go test ./...` must pass on every supported platform.
- **Public API changes** require a doc update and a note in the PR description.

## Commit Messages

Follow the [Conventional Commits](https://www.conventionalcommits.org/) format where reasonable:

```
<type>(<scope>): <short summary>

<body>

<footer>
```

Examples:

- `feat(rigrun): add ROCm backend for AMD GPUs`
- `fix(pyros): handle empty prompt in pillar 3`
- `docs: clarify deployment prerequisites`

## Pull Request Checklist

Before requesting review, confirm:

- [ ] Tests added or updated
- [ ] Documentation updated if behavior changed
- [ ] `go test ./...` passes locally
- [ ] `gofmt`, `go vet`, `staticcheck` clean
- [ ] Commit messages are clear and squashable
- [ ] PR description explains what and why, not just how

## Signing Off

All commits to Thornveil repositories must be signed off under the [Developer Certificate of Origin](https://developercertificate.org/). Use:

```bash
git commit -s -m "your message"
```

We also accept (and prefer) GPG-signed commits. See GitHub's docs on [signing commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits).

## Security Issues

**Do not file security issues in the public tracker.** Follow the process in [`SECURITY.md`](./SECURITY.md).

## Questions

For general questions, open a Discussion on the relevant repository. For private inquiries, reach out to **jesse@thornveil.ai**.

---

*Thornveil LLC · Tampa, FL*
