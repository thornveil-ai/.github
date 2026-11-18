# Thornveil

**Tactical autonomy, agent governance and edge AI R&D.**

Thornveil builds AI systems that run on customer hardware, in customer environments, under customer authorization. No cloud dependency. No subscription leash. No telemetry to vendors.

We build for defense, regulated industry, and data-sensitive teams who cannot send their data to someone else's servers.

> We build AI systems designed to be deployed, not demoed.

## What we build for

Most AI today means sending every query to a vendor's cloud. That doesn't work for federal programs, regulated industry, or data-sensitive operators who can't route their queries through someone else's enclave.

Local LLM serving is now economically and technically viable: capable open models run on commodity GPUs, structured generation is solved, and inference engines reach production reliability. The remaining gap is the application layer: the chat clients, agent gates and distributed inference mesh that turn raw inference into deployable systems.

Thornveil builds that application layer for customers who own their hardware, their data, and their authorization boundary.

## Engineering principles

- **Pure Go for the AI stack, pure Rust for embedded.** One binary per system. No Python in production paths.
- **Memory-safe by default.**
- **Signed and reproducible.** Every release is cosign-signed. Provenance is non-negotiable.
- **Local-first.** Privacy is the default architecture, not a feature toggle.
- **Dogfooded.** We use our own systems to build our own systems.

## Systems

Five systems, at different stages of maturity, that work together as one stack. **Signet** authorizes capability-bounded actions for any agent that needs a gate. **Pyros** is the inference engine inside **RigRun** (chat application) and **Mycelium** (distributed mesh). **Navigator** is the internal agent-production pipeline used to build them.

### Open source

- **[Signet](https://github.com/thornveil-ai/signet)**: Capability-based safety gates for LLM agents. The model proposes; Signet authorizes. Apache-2.0, on PyPI.

### Products

- **[RigRun](https://github.com/thornveil-ai/rigrun-overview)**: Professional AI chat with classification-gated routing. Local-first, designed for IL5. v1.0.4.
- **[Mycelium](https://github.com/thornveil-ai/mycelium-overview)**: Distributed AI mesh. Substitute-on-failure inference across heterogeneous nodes. v1.0.0.
- **[Pyros](https://github.com/thornveil-ai/pyros-overview)**: Adaptive inference engine that wraps any model backend.

## What's shipping

- **RigRun** (latest tag v1.0.4): Vision and image analysis, agentic tool use with approval flow, versioned artifacts, projects with classification floors, deep research with PDF reports, Docker-sandboxed code interpreter, local image generation.
- **NIST 800-53 design**: the RigRun stack is designed against 44 controls. No ATO or FedRAMP authorization is held.
- **Test discipline**: 6,900+ tests across the RigRun stack alone (Go unit, Vitest, Playwright E2E).
- **Org infrastructure**: ruleset enforcement, org-wide label sync, signed commits, reproducible builds, cosign-signed releases.

## Who we work with

We are looking for evaluation partners in federal programs, regulated industry, and defense primes building under accreditation. Engagements start with an NDA and a technical evaluation.

## Contact

- **Engagement, security and licensing**: [jesse@thornveil.ai](mailto:jesse@thornveil.ai)
- **Site**: [thornveil.ai](https://thornveil.ai)

---

*Your hardware. Your data. Your rules.*
