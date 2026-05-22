# Thornveil

**Sovereign AI infrastructure. Built at the edge.**

Thornveil builds AI systems that run on customer hardware, in customer environments, under customer authorization. No cloud dependency. No subscription leash. No telemetry to vendors.

We ship to defense, regulated industry, and data-sensitive teams who cannot send their data to someone else's servers.

> We build AI systems designed to be deployed — not demoed.

## What we build for

The dominant AI deployment pattern — send-the-query-to-a-vendor's-cloud — is structurally misaligned with sovereign work. Federal programs, regulated industry, and data-sensitive operators cannot route their queries through someone else's enclave, and they cannot wait for the vendor's next compliance cycle to ship.

Local LLM serving is now economically and technically viable: capable open models run on commodity GPUs, structured generation is solved, and inference engines reach production reliability. The remaining gap is the application layer — the chat clients, agent gates, distributed inference mesh, and perception backbones that turn raw inference into deployable systems.

Thornveil builds that application layer for customers who own their hardware, their data, and their authorization boundary — and intend to keep it that way.

## Engineering principles

- **Pure Go for the AI stack, pure Rust for embedded.** One binary per system. No Python in production paths.
- **Memory-safe by default.** Memory-corruption bugs that would crash a quadcopter sink a boat.
- **Signed and reproducible.** Every release is cosign-signed. Provenance is non-negotiable.
- **Local-first.** Privacy is the default architecture, not a feature toggle.
- **Dogfooded.** We use our own systems to build our own systems.

## Systems

Six production systems that interlock as a systems-of-systems stack. **Signet** authorizes capability-bounded actions for **Auspex** (autonomous offensive security) and any other agent that needs a gate. **Pyros** is the self-regulating inference engine consumed inside **RigRun** (chat application) and **Mycelium** (distributed mesh). **HawkStack** is the compute-aware perception-backbone family that feeds Canopy and other perception consumers.

### Open source

- **[Signet](https://github.com/thornveil-ai/signet)** — Capability-based safety gates for LLM agents. The model proposes; Signet authorizes. Apache-2.0.
- **[Alchemist](https://github.com/thornveil-ai/alchemist)** — Algorithm-aware C-to-Rust translation. One command, local LLM, five mandatory correctness gates. Apache-2.0.

### Commercial — sovereign AI products

- **[RigRun](https://github.com/thornveil-ai/rigrun-overview)** — Professional AI chat with classification-gated routing. Local, IL5-fit, federal pipeline.
- **[Mycelium](https://github.com/thornveil-ai/mycelium-overview)** — Distributed AI mesh. Substitute-on-failure inference across heterogeneous nodes.
- **[HawkStack](https://github.com/thornveil-ai/hawkstack-paper)** — Compute-aware neural-architecture topology theory. Sub-million-parameter perception backbones across six domains.

### Federal — gated

- **[Auspex](https://github.com/thornveil-ai/auspex-contact)** — AI red team gated by Signet. Federal/IL5-fit autonomous offensive security. EAR ECCN 4D004.

## What's shipping

- **RigRun v0.9** (February 2026) — Vision and image analysis, agentic tool use with approval flow, versioned artifacts, projects with classification floors, deep research with PDF reports, Docker-sandboxed code interpreter, local image generation.
- **HawkStack** — Six-domain results verified at 38K to 1.77M parameters: IRST (NUDT-SIRST 80.06% IoU), sonar (UATD 79.81% mAP), PCB defects (DeepPCB 97.63% mAP at 84K params), histopath (PanNuke), thermal-drone, ECG arrhythmia.
- **NIST 800-53 implementation** — 44 controls implemented and tested across the RigRun stack. IL5-fit. FedRAMP path active.
- **Test discipline** — 6,900+ tests across the RigRun stack alone (Go unit, Vitest, Playwright E2E). Substantive coverage across all systems.
- **Org infrastructure** — Tier-graded ruleset enforcement, org-wide label sync, signed commits, reproducible builds, cosign-signed releases.

## Who we work with

We work directly with operators in federal red-team programs, counter-UAS, regulated industry, and defense primes building under accreditation. Engagements start with an NDA, technical evaluation, and an export-control screen where applicable. We do not run public demos of gated systems.

## Contact

Each channel is scoped:

- **Engagement** — product evaluation, joint development, federal procurement intake: [jesse@thornveil.ai](mailto:jesse@thornveil.ai)
- **Security** — vulnerability disclosure, security questions: [jesse@thornveil.ai](mailto:jesse@thornveil.ai)
- **Legal / export controls** — EAR/ITAR, licensing, commercial terms: [jesse@thornveil.ai](mailto:jesse@thornveil.ai)
- **Site** — [thornveil.ai](https://thornveil.ai)

---

*Your hardware. Your data. Your rules.*
