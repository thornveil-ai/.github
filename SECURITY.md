# Security Policy

Thornveil builds security-first AI infrastructure. We take vulnerability reports seriously and treat coordinated disclosure as a partnership.

## Reporting a Vulnerability

**Do not open a public issue for security vulnerabilities.**

Report security issues privately by email to:

📬 **security@thornveil.ai**

If you don't get a response within **72 hours**, follow up to **jesse@thornveil.ai**.

### What to Include

To help us triage quickly, please include as much of the following as you can:

- A clear description of the issue and its impact
- The affected product, version, and platform (RigRun, Pyros, Mycelium, Agent Factory, or another Thornveil component)
- Steps to reproduce, including any proof-of-concept code or commands
- Any relevant logs, stack traces, or environment details
- Your name and affiliation (optional — anonymous reports accepted)

## Our Commitment

When you report a vulnerability in good faith, we will:

- **Acknowledge** your report within 72 hours
- **Triage and validate** the issue, typically within 7 days
- **Keep you informed** of progress through remediation
- **Coordinate disclosure timing** with you before any public advisory
- **Credit you** in release notes and advisories (unless you prefer to remain anonymous)

## Scope

In scope for this policy:

- All Thornveil-published binaries, container images, and source repositories under the [`thornveil-ai`](https://github.com/thornveil-ai) organization
- Thornveil-operated services (when applicable)
- Issues in third-party dependencies that materially impact Thornveil products

Out of scope:

- Vulnerabilities in third-party software not bundled or distributed by Thornveil
- Social engineering of Thornveil personnel
- Physical attacks against Thornveil infrastructure
- Denial-of-service attacks (please report, do not demonstrate)
- Findings from automated scanners without demonstrated impact

## Safe Harbor

Thornveil will not pursue civil or criminal action against researchers who:

- Make a good-faith effort to comply with this policy
- Avoid privacy violations, data destruction, and service degradation
- Give us reasonable time to remediate before any public disclosure
- Do not exploit a vulnerability beyond what is necessary to demonstrate it

## Supported Versions

Security fixes are issued for the latest minor release of each Thornveil product line. Older versions may receive fixes at our discretion based on severity and customer impact. Refer to each product repository's `SECURITY.md` or release notes for specifics.

## Cryptographic Verification

All Thornveil release artifacts are signed with [cosign](https://github.com/sigstore/cosign). Always verify signatures before deploying to production. Signing keys and verification instructions are published in each product repository.

---

*Last updated: 2026 · Thornveil LLC · Tampa, FL*
