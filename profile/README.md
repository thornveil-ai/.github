# Thornveil

**Sovereign AI infrastructure. Built at the edge.**

Thornveil builds AI systems that run on customer hardware, in customer environments, under customer authorization. No cloud dependency. No subscription leash. No telemetry to vendors.

We ship to defense, regulated industry, and data-sensitive teams who cannot send their data to someone else's servers.

## Engineering principles

- **Pure Go for the AI stack, pure Rust for embedded.** One binary per system. No Python in production paths.
- **Memory-safe by default.** Memory-corruption bugs that would crash a quadcopter sink a boat.
- **Signed and reproducible.** Every release is cosign-signed. Provenance is non-negotiable.
- **Local-first.** Privacy is the default architecture, not a feature toggle.
- **Dogfooded.** We use our own systems to build our own systems.

## Systems

Six production systems and their public-facing surfaces.

### Open source

- **[Signet](https://github.com/thornveil-ai/signet)** — Capability-based safety gates for LLM agents. The model proposes; Signet authorizes. Apache-2.0.
- **[Alchemist](https://github.com/thornveil-ai/alchemist)** — Algorithm-aware C-to-Rust translation. One command, local LLM, five mandatory correctness gates. Apache-2.0.

### Commercial — sovereign AI products

- **[RigRun](https://github.com/thornveil-ai/rigrun-overview)** — Professional AI chat with classification-gated routing. Local, IL5-fit, federal pipeline.
- **[Mycelium](https://github.com/thornveil-ai/mycelium-overview)** — Distributed AI mesh. Substitute-on-failure inference across heterogeneous nodes.
- **[HawkStack](https://github.com/thornveil-ai/hawkstack-paper)** — Compute-aware neural-architecture topology theory. Sub-million-parameter perception backbones across six domains.

### Federal — gated

- **[Auspex](https://github.com/thornveil-ai/auspex-contact)** — AI red team gated by Signet. Federal/IL5-fit autonomous offensive security. EAR ECCN 4D004.

## Contact

- Engagement: [jesse@thornveil.ai](mailto:jesse@thornveil.ai)
- Security: [security@thornveil.ai](mailto:security@thornveil.ai)
- Legal / export controls: [legal@thornveil.ai](mailto:legal@thornveil.ai)
- Site: [thornveil.ai](https://thornveil.ai)
