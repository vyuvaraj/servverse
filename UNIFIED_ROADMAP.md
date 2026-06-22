# Serv Unified Ecosystem Roadmap & Architect Analysis

> Single source of truth for the **Serv** ecosystem: Serv-lang, ServGate, ServStore, ServQueue, ServConsole, and the Serv-verse vision.  
> Last updated: June 2026 — Full architectural review completed.

---

## Completion Tracker

### Overall Ecosystem Progress

| Component | Core Phases | Done | Open | Completion | Status Bar |
|-----------|-------------|------|------|------------|------------|
| **Serv-lang** | Phases 1–12 + proposed 13–15 | 88 | 21 | **81%** | ████████████████░░░░░ |
| **ServStore** | Phases 1–7 + proposed 8–10 | 54 | 21 | **72%** | ██████████████░░░░░░░ |
| **ServGate** | Phases 1–7 + proposed 8–10 | 27 | 18 | **60%** | ████████████░░░░░░░░░ |
| **ServQueue** | Phases 1–7 + proposed 8–10 | 27 | 20 | **57%** | ███████████░░░░░░░░░░ |
| **ServConsole** | Phases 1–5 + proposed 6–8 | 11 | 30 | **27%** | █████░░░░░░░░░░░░░░░░ |
| **ServRegistry** | Core + hardening | 6 | 0 | **100%** | █████████████████████ |
| **Unified Roadmap** (cross-cutting) | Sections 8–9 | 35 | 36 | **49%** | ██████████░░░░░░░░░░░ |
| | | | | | |
| **TOTAL ECOSYSTEM** | | **247** | **147** | **63%** | █████████████░░░░░░░░ |

### Core vs Proposed Breakdown

| Component | Core (Shipped) | Core % | Proposed (Future) | Proposed % |
|-----------|---------------|--------|-------------------|------------|
| **Serv-lang** | 82/82 | **100%** ✅ | 6/27 | 22% |
| **ServStore** | 49/53 | **92%** | 5/22 | 23% |
| **ServGate** | 21/24 | **88%** | 6/21 | 29% |
| **ServQueue** | 22/24 | **92%** | 5/23 | 22% |
| **ServConsole** | 10/18 | **56%** | 1/23 | 4% |
| **ServRegistry** | 6/6 | **100%** ✅ | — | — |

### Phase Completion by Project

#### Serv-lang
| Phase | Description | Status |
|-------|-------------|--------|
| 1–8 | Language Foundations → Module System | ✅ 100% |
| 9 | Distribution & Ecosystem | ✅ 100% |
| 10 | Next Level (Generics, Actors, WASM, Workflows) | ✅ 100% |
| 11 | Project System & Developer Tooling | ✅ 100% |
| 12 | Servverse Native Integration | ✅ 100% |
| 13 | Adapter Expansion & DX (proposed) | 🟡 50% (6 open) |
| 14 | Next-Level Language Evolution (proposed) | 🟡 20% (8 open) |
| 15 | Differentiating Factors (proposed) | ⬜ 0% |

#### ServStore
| Phase | Description | Status |
|-------|-------------|--------|
| 1 | MVP Core | ✅ 100% |
| 2 | Security, Extended Features, Observability | ✅ 100% |
| 3 | Distributed Clustering & Data Protection | ✅ 100% |
| 4 | Horizontal Scaling & Kubernetes | ✅ 100% |
| 5 | AI-Native Storage Engine | ✅ 100% |
| 6 | Enterprise Hardening & Chaos Engineering | ✅ 100% |
| 7 | Serv-verse & Next-Gen Enhancements | 🟡 75% (3 open) |
| 8 | Operational Hardening (proposed) | ⬜ 0% |
| 9 | Next-Level Distributed Storage (proposed) | ⬜ 0% |
| 10 | Differentiating Factors (proposed) | ⬜ 0% |

#### ServGate
| Phase | Description | Status |
|-------|-------------|--------|
| 1 | Core Reverse Proxy & WASM | ✅ 100% |
| 2 | Performance Optimizations | ✅ 100% |
| 3 | Pluggable Protocols (gRPC, WebSocket) | ✅ 100% |
| 4 | Production Security & Resilience | ✅ 100% |
| 5 | Ecosystem & Console Integration | 🟡 33% (2 open) |
| 6 | Traffic Replay & Developer Tooling | ✅ 100% |
| 7 | Advanced Policies & AI Capabilities | ✅ 100% |
| 8 | Operational Hardening (proposed) | ⬜ 0% |
| 9 | Next-Level API Gateway (proposed) | ⬜ 0% |
| 10 | Differentiating Factors (proposed) | ⬜ 0% |

#### ServQueue
| Phase | Description | Status |
|-------|-------------|--------|
| 1 | Core Foundation & WASM Integration | ✅ 100% |
| 2 | Production Observability & Security | ✅ 100% |
| 3 | Cluster Consensus & Distributed Replication | ✅ 100% |
| 4 | ServStore Tiered Storage | ✅ 100% |
| 5 | Deep Ecosystem Integration | ✅ 100% |
| 6 | Enterprise Features | ✅ 100% |
| 7 | Serv-verse Infrastructure Integrations | 🟡 67% (1 open: console control plane) |
| 8 | Operational Hardening (proposed) | ⬜ 0% |
| 9 | Next-Level Message Broker (proposed) | ⬜ 0% |
| 10 | Differentiating Factors (proposed) | ⬜ 0% |

#### ServConsole
| Phase | Description | Status |
|-------|-------------|--------|
| 1 | Unified Console Portal | ✅ 100% |
| 2 | SQL & DB Schema Inspector | 🟡 67% (1 open: migration auditing) |
| 3 | Cluster Operations & Repair Panel | ✅ 100% |
| 4 | Enterprise Access Control & Audit Logs | 🟡 67% (1 open: RBAC editor) |
| 5 | Ecosystem Integration Depth | 🟡 60% (2 open) |
| 6 | Operational Hardening (proposed) | ⬜ 0% |
| 7 | Next-Level Observability (proposed) | ⬜ 0% |
| 8 | Differentiating Factors (proposed) | ⬜ 0% |

---

## 0. Senior Architect Analysis (June 2026)

### Ecosystem Maturity Snapshot

| Project | Phases Done | Open Items | Maturity |
|---|---|---|---|
| **Serv-lang** | Phases 1–11 (all core complete) + partial Phase 12 | remaining Phase 12 items | ⭐⭐⭐⭐⭐ — Production-ready |
| **ServStore** | Phases 1–7 (all core complete) | ServConsole link | ⭐⭐⭐⭐⭐ — Production-ready |
| **ServGate** | Phases 1–6 + partial 7 | Policy-as-Code | ⭐⭐⭐⭐ — Strong |
| **ServQueue** | Phases 1–6 (all core complete) | Phase 7 integrations | ⭐⭐⭐⭐½ — Production-ready |
| **ServConsole** | Phases 1, 3, 5 + partial 4 | Phase 2 (DB inspector), Phase 4 remainder (RBAC editor) | ⭐⭐⭐⭐ — Highly capable |

---

### Critical Cross-Project Gaps

**🔴 Gap 1 — No Shared AuthN/AuthZ Layer**
ServGate uses Bearer tokens, ServStore uses JWT/OIDC/LDAP+RBAC, ServQueue uses basic/token STOMP auth, ServConsole proxies tokens but has no SSO. Four separate credential systems. An operator running all four services must manage four independent auth configurations. This is the single biggest blocker for treating the ecosystem as a unified platform.

**🔴 Gap 2 — Serv-lang 10.9 (Servverse Connectors) Is Unstarted**
Without native `servqueue://` and `servgate://` URI connectors in the compiler, Serv-lang developers must hand-write HTTP calls to use the ecosystem. The core promise — "write `.srv` code, ecosystem handles infra" — is not fulfilled at the language level.

**🔴 Gap 3 — ServQueue Has No Dead Letter Queue**
Failed WASM transforms silently drop messages in production. DLQ is the minimum reliability bar for any production messaging system. Phase 6 is unstarted.

**🔴 Gap 4 — ServConsole Assumes Static Localhost Ports**
`storeUrl`, `gateUrl`, `queueUrl` are hardcoded CLI flags defaulting to localhost. In Docker Compose, Kubernetes, or any multi-host deployment, service discovery is required. This blocks real operational use of the console.

**🟠 Gap 5 — No End-to-End Trace Correlation**
ServGate, ServStore, and ServQueue all emit OTel spans independently. There is no shared OTLP collector config or shared `traceId` propagation across all four services. A cross-service request (Gate → Queue → Store) produces three disconnected trace trees.

**🟠 Gap 6 — ServGate Config Is File-Coupled**
Routes live in `config.json` protected by a single mutex. Multi-replica ServGate deployments cannot share config. ServConsole writes to a local file — which only works on one machine.

**🟠 Gap 7 — No Running Package Registry**
`serv install <pkg>` hits a dead URL. The community registry CLI exists but there is no running registry server. This blocks the third-party module ecosystem from forming.

**🟡 Gap 8 — ServStore HNSW Vector Index Pending**
The current TF-IDF semantic search is functional for demos but not production-grade. HNSW is required for the "AI-native storage" positioning to be credible at scale.

---

### Architectural Recommendations

**Rec 1 — Define the "Servverse Wire Protocol"**  
A single `SERVVERSE_DISCOVERY` env var points to a lightweight JSON manifest:
```json
{
  "gate":          "http://localhost:8080",
  "store":         "http://localhost:8081",
  "queue":         "http://localhost:8082",
  "console":       "http://localhost:8083",
  "jwt_secret":    "shared-secret-or-oidc-issuer-url",
  "otlp_endpoint": "http://localhost:4318"
}
```
Every service reads this at startup. One env var wires the entire ecosystem.

**Rec 2 — ServStore as the Control Plane**  
ServGate should store route configuration in a ServStore bucket (`serv-config`) rather than a local JSON file. Multi-replica ServGate gets eventual consistency for free. ServConsole gets a natural distributed read/write target. No new infrastructure (etcd, Consul) needed.

**Rec 3 — Adapters First, Platform Second (SERVVERSE_ALT alignment)**  
Build adapter connectors in Serv-lang (servqueue://, servgate://, serv-ai, serv-deploy targets) before building competing managed services (ServDB, ServCache, ServCron). The adapter layer drives adoption; the managed services can be upsells.

**Rec 4 — ServConsole as the Integration Harness**  
Every cross-project integration claim should produce a visible ServConsole UI element before being marked complete. This gives the ecosystem a live integration test harness at all times.

---

## 1. Immediate Action Items & Todos

### Release & Distribution
- [x] **Publish VS Code Extension to Marketplace**
  - [x] Register publisher `vyuvaraj` at [Marketplace Console](https://marketplace.visualstudio.com/manage).
  - [x] Generate PAT with Marketplace Manage scope in Azure DevOps.
  - [x] Package and publish the extension from `Serv-lang/vscode-support/extension`.
- [x] **Publish Scoop Manifest & Homebrew Formula**
  - [x] Create a GitHub release for `Serv-lang` with `serv.exe` attached.
  - [x] Update and publish Scoop manifest pointing to the release.
  - [x] Tap and update the Homebrew formula in `brew install serv`.

### Promotion & Articles
- [ ] **Publish Medium Articles** (Deferred)
  - [ ] Create hero/terminal screenshots of `serv run`.
  - [x] Write and publish Serv-lang article first.
  - [ ] Publish ServStore article 3–5 days later.
  - [ ] Publish ServConsole article after ServStore.
  - [ ] Cross-link between the articles and link the VS Code extension.

---

## 2. Serv-lang Roadmap & Status

Serv-lang compiles directly to native binaries via Go code generation.

### Completed Foundations (Phases 1–11) — All Done ✅
- **Language Syntax**: Modulo, loops, compound assignment, bitwise operators, slice expressions.
- **Type System**: Type inference, return type propagation, null safety (`T?`), union types (`T | error`).
- **Error Model**: Error returns and `?` propagation.
- **Performance**: Escape-analysis SafeMap, AOT constant folding, prepared statement cache.
- **LSP / Tooling**: Autocomplete, hover, go-to-definition, workspace rename & find references, DAP debugger.
- **Testing**: Structured assertions, cover metrics, setup/teardown hooks, structured mocking.
- **Advanced**: Generics, Actor Model, ORM generation, Distributed Trace Propagation, Stateful Workflows, WASM target.
- **Ecosystem**: Web playground (WASM Monaco sandbox), community package registry CLI, Docker base image.
- **Project System**: `serv.toml`, multi-file compilation, environment profiles, scoped symbol table.

### Phase 10 Remaining
- [x] **10.9 Serv-verse Core Integrations** — Develop unified connectors targeting ServQueue and ServGate. *(See Phase 12)*

### Phase 12: Servverse Native Integration (New)
- [x] **12.1 `servqueue://` compiler connector** — Native URI driver for ServQueue STOMP; enables `broker "servqueue://host"` from `.srv` code without HTTP boilerplate.
- [x] **12.2 `servgate://` route registration** — Self-announce service routes to ServGate at startup via a compiler-emitted registration call.
- [x] **12.3 `serv deploy --target k8s`** — Generate Kubernetes Deployment + Service YAML from `serv.toml`.
- [x] **12.4 `serv deploy --target fly`** — Generate `fly.toml` and trigger Fly.io deployment.
- [x] **12.5 `serv new <template>`** — Starter project scaffolding (`api`, `worker`, `event-processor`, `full-stack`).
- [x] **12.6 `serv-ai` adapter** — `ai "openai://gpt-4"`, `ai "anthropic://claude-3"`, `ai "ollama://localhost"` connection strings with `ai.complete()` / `ai.embed()` API.
- [x] **12.7 `serv monitor`** — Terminal htop-style runtime inspector showing live request rate, latency, goroutines, and route-level breakdown.

---

## 3. ServStore Roadmap & Status

ServStore is a cloud-native, distributed, S3-compatible object storage engine.

### Completed Core (Phases 1–6) — All Done ✅
- **Core Storage**: S3-compatible REST API, versioning, multipart uploads, WORM locks, pre-signed URLs.
- **Security**: Signature V4, AES-256-GCM at-rest, TLS 1.3, RBAC, user policy management.
- **Distributed System**: Gossip membership, Raft consensus, consistent hashing, P2P auto-healing, Reed-Solomon erasure coding, BLAKE3 checksums, cross-region replication.
- **AI-Native**: CAS content addressing, time travel queries, TF-IDF semantic search, WASM transforms.
- **Cloud-Native**: Kubernetes Operator, CRDs, Helm charts, CSI plugin.
- **Observability**: Prometheus metrics, JSON logging, OTel tracing.

### Phase 7 Additions (Proposed)
- [x] **LSM-Tree Metadata Engine** — Pebble-backed sub-millisecond metadata ops.
- [x] **Transform Pipeline DAG Engine** — Chained WASM pipeline execution.
- [x] **HNSW Vector Indexing** — Upgrade TF-IDF to HNSW via local ONNX embeddings for production-grade semantic search.
- [x] **`/console/schema` API endpoint** — Expose table/index metadata for ServConsole DB Inspector.
- [ ] **ServConsole Unified Management** — Full dashboard link for cluster metrics, replication lag, and OTel traces. *(ServConsole Phase 2/3 in progress)*

---

## 4. ServGate Roadmap & Status

### Completed (Phases 1–4, 6, partial 7)
- Core reverse proxy, WASM middleware, OTel tracing, TLS, rate limiting, circuit breakers.
- Traffic replay, WASM middleware marketplace, Serv-lang WASM compilation.
- AI-native gateway features (semantic caching, prompt guard, PII redaction).

### Open Items
- [ ] **Phase 5 — ServConsole Administration**: Route management, active connection view, WASM swap via console.
- [x] **Phase 5 — Distributed config backend**: Store routes in a ServStore bucket (`serv-config`) for multi-replica deployments.
- [ ] **Phase 5 — ServConsole OIDC-aware route sync**: Sign config writes with JWT before persisting.
- [x] **Phase 7 — Policy as Code**: Compile `.policy` files to WASM executable access controls.
- [x] **Phase 7 — ServGate → ServQueue webhook bridge**: Register routes that publish to ServQueue topics on incoming HTTP.

---

## 5. ServQueue Roadmap & Status

### Completed (Phases 1–5)
- Thread-safe pub/sub engine, STOMP TCP server, HTTP management API.
- WASM sandbox integration, TLS, auth, OTel metrics & tracing, WASM module caching.
- Raft-backed clustering, partitioned queues, high-availability failover.
- WAL + cold data offloading to ServStore, log replay.
- Serv-lang `servqueue://` driver, ServConsole integration feeds, auto-trace propagation.

### Phase 6: Enterprise Features (High Priority — Unstarted)
- [x] **Dead Letter Queues (DLQ)** — Route failed WASM transform messages to `.dlq` topic after max-retries. Critical reliability gap.
- [ ] **Delayed & Scheduled Messages** — Timed-wheel delivery with configurable delay parameter.
- [x] **Message Deduplication** — Deduplicate publishes within configurable window by unique message ID.

### Phase 7: Servverse Infrastructure Integrations
- [x] **ServGate Webhook Triggers** — Register ServGate routes that publish directly to ServQueue topics.
- [x] **Dynamic WASM hot-swap without dropping connections** — Swap transform modules without disconnecting active STOMP subscribers.
- [ ] **ServConsole Unified Control Plane** — Topic administration, WAL inspection, WASM debug panels in the dashboard.

---

## 6. ServConsole Roadmap & Status

### Completed
- Phase 1: Aggregation engine, glassmorphic dashboard, gateway editor, WASM hot-swap UI, hash ring visualizer, OTel trace waterfall.
- Phase 3: Cluster ops panel — replication lag table, erasure coding health, rebalance trigger.

### Phase 2: SQL & DB Schema Inspector (Q3 2026)
- [x] **DB Schema ORM Viewer** — Visual diagram of Serv-lang ORM-generated database schemas.
- [x] **SQL Query Workbench** — Secure web console to run queries against connected database adapters.
- [ ] **Migration Auditing** — Track schema revisions and delta logs from the UI.

### Phase 4: Enterprise Access Control & Audit Logs (Q1 2027)
- [x] **Console SSO** — Integrated OIDC/OAuth2 and LDAP user sign-ins.
- [ ] **RBAC Policy Editor** — Create and apply granular user security policies for S3 buckets and STOMP topics.
- [x] **Audit Logs Dashboard** — Immutable log of administrative operations (WASM hot-swaps, route creations).

### Phase 5: Ecosystem Integration Depth (Q2 2027) [New]
- [x] **Service Discovery Config** — Replace hardcoded localhost ports with a `services.json` or `SERVVERSE_DISCOVERY` env-var registry.
- [x] **Shared OTel Collector Config** — Surface a single OTLP endpoint setting that propagates to all connected services; unified trace correlation.
- [ ] **ServQueue Topic Admin** — Full WAL inspection, delayed message queue view, and WASM debug panels.
- [ ] **ServGate Multi-Replica Config Sync** — Write route configs to ServStore-backed distributed storage.
- [ ] **Cross-Service Dependency Graph** — Visual map of which Serv services talk to which infrastructure components.

---

## 7. Ecosystem & Platform Integration (Serv-verse)

### Strategic Approach: Adapters First, Platform Second
Build adapter connectors and developer tooling before building competing managed services.

```
┌─────────────────────────────────────────────────────────────────────┐
│                        DEVELOPER LAYER                              │
├─────────────────────────────────────────────────────────────────────┤
│  Serv-lang  │ ServIDE   │ ServPlayground │ ServRegistry │ ServTunnel│
│  (compiler) │ (editor)  │ (web sandbox)  │ (packages)   │ (tunnels) │
├─────────────────────────────────────────────────────────────────────┤
│                        PLATFORM LAYER                               │
├─────────────────────────────────────────────────────────────────────┤
│  ServCloud    │  ServGateway │  ServMesh        │  ServCI           │
│  (deploy)     │  (API mgmt)  │  (service mesh)  │  (build+test)     │
├─────────────────────────────────────────────────────────────────────┤
│                      INFRASTRUCTURE LAYER                           │
├─────────────────────────────────────────────────────────────────────┤
│  ServStore    │  ServQueue   │  ServCache       │  ServDB           │
│  (object)     │  (messaging) │  (distributed)   │  (database)       │
├─────────────────────────────────────────────────────────────────────┤
│                      OBSERVABILITY LAYER                            │
├─────────────────────────────────────────────────────────────────────┤
│  ServConsole  │  ServTrace   │  ServMetrics     │  ServAlerts       │
│  (dashboard)  │  (tracing)   │  (metrics)       │  (on-call)        │
└─────────────────────────────────────────────────────────────────────┘
```

### Active Platform Infrastructure
- [x] **ServStore** — S3-compatible distributed object storage with inline WASM pipeline transforms.
- [x] **ServQueue** — WASM-enabled STOMP & HTTP message broker with compute-in-queue transforms.
- [x] **ServGate** — Programmable API Gateway with AI-native middleware and circuit breaking.
- [x] **ServConsole** — Unified web dashboard with cluster ops panel, OTel trace waterfall, and WASM hot-swap UI.

### Ecosystem Flywheel Items (Future)
- [ ] **ServRegistry** — Running registry server backed by ServStore for `serv install` packages.
- [ ] **ServPlayground** — WASM-hosted browser sandbox (zero-install try-it experience).
- [ ] **ServCron** — Distributed scheduler for `every` / `cron` declarations (exactly-once, leader election).
- [ ] **serv-ai** — AI adapter: OpenAI, Anthropic, Ollama connection strings.
- [ ] **ServCI** — Serv-native build + test pipeline service.
- [ ] **ServTunnel** — Secure local tunnel service for exposing endpoints to internet webhooks.

---

## 8. Master Priority Matrix

### 🔴 P1 — Foundation (Do First, Blocks Everything Else)

| # | Task | Project(s) | Rationale | Status |
|---|---|---|---|---|
| P1-1 | **Shared JWT/OIDC auth across all services** | All | Four auth systems = four credential silos. One shared `SERV_JWT_SECRET` / OIDC config unblocks team use. | [x] |
| P1-2 | **ServQueue Dead Letter Queues** | ServQueue | Silent message drops in production = data loss. DLQ is the minimum reliability bar. | [x] |
| P1-3 | **Serv-lang `servqueue://` compiler connector** | Serv-lang | Closes the compiler→broker loop. The most impactful unfinished item in the ecosystem. | [x] |
| P1-4 | **ServConsole service discovery config** | ServConsole | Hardcoded localhost ports = console can only run on one machine. Blocks Docker + k8s use. | [x] |

### 🟠 P2 — Hardening (Close the Quality Gap)

| # | Task | Project(s) | Rationale | Status |
|---|---|---|---|---|
| P2-1 | **Shared OTel collector config (SERV_OTLP_ENDPOINT)** | All | Gate + Queue + Store emit spans; none share a collector. No end-to-end trace correlation today. | [x] |
| P2-2 | **ServConsole SSO (OIDC login)** | ServConsole | Anyone reaching port 8083 has admin access today. | [x] |
| P2-3 | **ServConsole Audit Logs Dashboard** | ServConsole | Immutable ops log is a security requirement for any shared-team console. | [x] |
| P2-4 | **ServGate distributed config via ServStore bucket** | ServGate | Multi-replica ServGate cannot share routes today. | [x] |
| P2-5 | **ServQueue Message Deduplication** | ServQueue | Idempotent at-least-once delivery without dedup is a reliability anti-pattern. | [x] |
| P2-6 | **ServStore HNSW Vector Index** | ServStore | TF-IDF is a demo; HNSW is the production-grade vector layer. | [x] |

### 🟡 P3 — Integration Depth

| # | Task | Project(s) | Rationale | Status |
|---|---|---|---|---|
| P3-1 | **ServConsole Phase 2 — DB Schema ORM Viewer** | ServConsole | Visualizes Serv-lang ORM output in the console. Closes compiler→console loop. | [x] |
| P3-2 | **ServGate → ServQueue webhook bridge** | ServGate + ServQueue | Register routes that fire queue publishes. Connects gateway and broker. | [x] |
| P3-3 | **ServQueue dynamic WASM hot-swap** | ServQueue | Zero-downtime transform updates without dropping STOMP connections. | [x] |
| P3-4 | **Serv-lang `servgate://` route registration** | Serv-lang | Services self-announce to the gateway at startup. True zero-config routing. | [x] |
| P3-5 | **ServConsole Phase 2 — SQL Query Workbench** | ServConsole | Interactive query panel. High developer value. | [x] |
| P3-6 | **ServStore `/console/schema` API** | ServStore | Backend endpoint that ServConsole DB Inspector queries for schema metadata. | [x] |

### 🟢 P4 — Ecosystem Growth

| # | Task | Project(s) | Rationale | Status |
|---|---|---|---|---|
| P4-1 | **VS Code Extension marketplace publish** | Serv-lang | Deferred too long. Every day = lost discoverability. | [ ] |
| P4-2 | **ServRegistry server (backed by ServStore)** | Ecosystem | `serv install` hits a dead URL. Unblocks third-party module ecosystem. | [x] |
| P4-3 | **`serv deploy --target k8s`** | Serv-lang | Kubernetes YAML generation. High adoption leverage, low build cost. | [ ] |
| P4-4 | **`serv new <template>`** | Serv-lang | Starter scaffolding. Dramatically lowers new-project friction. | [ ] |
| P4-5 | **ServConsole RBAC Policy Editor** | ServConsole | UI to create/edit S3 bucket and STOMP topic access rules. | [ ] |
| P4-6 | **Medium articles — ServStore + ServConsole** | Marketing | Articles on Serv-lang, ServStore, ServGate, ServConsole, and Servverse completed in `/articles`. | [x] |

### 🔵 P5 — Strategic Bets

| # | Task | Project(s) | Rationale |
|---|---|---|---|
| P5-1 | **ServPlayground — WASM browser sandbox** | Ecosystem | Highest adoption lever for Serv-lang. Zero-install experience. |
| P5-2 | **`serv-ai` adapter** | Serv-lang | High-demand. Synergizes with ServStore's AI-native positioning. |
| P5-3 | **`serv monitor` CLI** | Serv-lang | Terminal htop for a running service. Fills gap before ServMetrics. |
| P5-4 | **ServCron — distributed scheduler** | Ecosystem | `every 5m {}` needs exactly-once distributed execution at scale. |
| P5-5 | **ServConsole cross-service dependency graph** | ServConsole | Visual map of service→infra dependencies. Strategic differentiator. |

---

## 9. Cross-Cutting Improvements (Proposed — Q3 2026)

The following items address quality, consistency, and adoption gaps that span multiple projects. They don't add new features but harden the ecosystem for production use and improve developer experience.

### 🔧 Operational Hardening

| # | Task | Project(s) | Rationale | Status |
|---|---|---|---|---|
| X-1 | **Standardized `/healthz` and `/readyz` endpoints** | All | No service exposes health probes today. Blocks k8s liveness/readiness, Docker healthchecks, and ServConsole auto-status. | [x] |
| X-2 | **Graceful shutdown on SIGTERM** | All | No service handles SIGTERM gracefully. Causes connection drops during k8s rolling updates and Docker stop. | [x] |
| X-3 | **Standardized error response contract** | All | Each service returns different error JSON shapes. Standardize: `{"error": "msg", "code": "ERR_CODE", "trace_id": "..."}`. | [x] |
| X-4 | **API versioning (`/v1/` prefixes)** | ServGate, ServQueue, ServStore, ServConsole, ServRegistry | No admin API is versioned. Breaking changes will be costly once external consumers exist. | [x] |
| X-5 | **Shared `pkg/health` Go package** | All | Extract a reusable health/readiness module that every service imports. Reduces duplication and enforces consistency. | [ ] |
| X-6 | **Docker Compose healthchecks** | All | `depends_on` without `condition: service_healthy` means services start before dependencies are ready. | [x] |
| X-7 | **CI/CD pipelines (GitHub Actions)** | ServStore, ServGate, ServQueue, ServConsole, ServRegistry | Only Serv-lang has CI. All other projects lack automated build/test/lint on PR. | [x] |

### 🔌 Runtime Adapter Expansion (Serv-lang)

| # | Task | Rationale | Status |
|---|---|---|---|
| A-1 | **`auth` keyword & adapter** (`auth "oidc://..."`, `auth "keycloak://..."`, `auth "auth0://..."`) | Most requested feature category for backend services. Middleware auto-validates tokens. | [x] |
| A-2 | **`search` keyword & adapter** (`search "meilisearch://..."`, `search "elastic://..."`) | Full-text search is table-stakes for many services. | [x] |
| A-3 | **`mail` keyword & adapter** (`mail "smtp://..."`, `mail "ses://..."`, `mail "sendgrid://..."`) | Transactional email is needed in almost every web service. | [x] |
| A-4 | **MySQL database adapter** (`database "mysql://..."`) | Second most popular RDBMS globally — major adoption blocker to not support it. | [x] |
| A-5 | **`store` keyword (multi-backend)** (`store "s3://..."`, `store "gcs://..."`, `store "r2://..."`) | The existing `s3.srv` stdlib only targets ServStore. A unified `store` keyword unlocks any object storage. | [x] |
| A-6 | **Redis Streams broker adapter** (`broker "redis-stream://..."`) | Lightweight alternative to Kafka/NATS for teams already running Redis. | [ ] |
| A-7 | **Graceful shutdown in generated code** | Generated `main.go` should use `signal.NotifyContext` to drain connections and flush spans on SIGTERM. | [x] |
| A-8 | **Standardized error response contract** | Generated HTTP handlers return `{"error": "msg", "code": "...", "trace_id": "..."}` on failure by default. | [x] |
| A-9 | **Full OIDC discovery & JWKS validation** | `auth "oidc://issuer"` currently only validates issuer claim. Add `.well-known` discovery, JWKS key caching, RS256/ES256 signature verification, and key rotation support. | [ ] |
| A-10 | **Auth role/scope guards** | `route ... use [auth.role("admin")]` — compile-time syntax for role/scope-based route access using JWT claims. | [ ] |

### 📦 ServRegistry Hardening

| # | Task | Rationale | Status |
|---|---|---|---|
| R-1 | **Package versioning** | Re-publish currently overwrites. Key format should be `{name}/{version}/{name}-{version}.tar.gz`. | [x] |
| R-2 | **Package metadata (`metadata.json`)** | Store version history, description, dependencies, and checksums per package. | [x] |
| R-3 | **Version listing API** (`GET /api/packages/{name}/versions`) | Required for `serv install pkg@1.2.0` to work. | [x] |
| R-4 | **Publish authentication** | Anyone can publish today. Require valid JWT from `SERV_JWT_SECRET`. | [x] |
| R-5 | **Search index** | Currently only lists all objects. Add in-memory trie or prefix search loaded from S3 listing at startup. | [x] |
| R-6 | **Dependency resolution** | Parse `serv.toml` dependencies and resolve transitive requirements on install. | [x] |

### 🧪 Integration & Quality

| # | Task | Project(s) | Rationale | Status |
|---|---|---|---|---|
| Q-1 | **End-to-end integration test suite** | All | No test exercises the full stack (Gate → Queue → Store → Console). Add `e2e/` directory with Go tests against Docker Compose. | [x] |
| Q-2 | **Shared JWT/OTel init package** | All | Each service reimplements JWT validation, OTel tracer init, and health checks. Extract shared `servverse/pkg/shared`. | [ ] |
| Q-3 | **WebSocket push for real-time dashboards** | ServConsole | Console polls data. Real-time push (WebSocket/SSE) for traces, queue flow, and route hit counters. | [x] |
| Q-4 | **Canonical `serv.toml` example** | Serv-lang | No documented example of a multi-file project manifest. New users confused about what goes in it. | [x] |
| Q-5 | **ServStore bucket event notifications** | ServStore | Emit `s3:ObjectCreated`/`s3:ObjectRemoved` events to a webhook or ServQueue topic — enables event-driven patterns. | [x] |
| Q-6 | **ServQueue consumer group support** | ServQueue | Multiple subscribers in a group with partition assignment. Required for horizontal scaling of consumers. | [ ] |
| Q-7 | **ServGate config hot-reload** | ServGate | Watch config source (file or ServStore bucket) for changes and apply route updates without process restart. | [x] |

---

## 10. Suggested Priority Reordering

Based on current ecosystem maturity and adoption leverage, the recommended execution order for remaining items:

1. **VS Code Extension marketplace publish** — hours of work, permanent discoverability gain (P4-1)
2. **Health probes + Docker Compose healthchecks** (X-1, X-5, X-6) — blocks real k8s/compose adoption
3. **ServRegistry v2** (R-1 through R-5) — `serv install` is the ecosystem flywheel
4. **E2E integration test suite** (Q-1) — regression safety net as cross-service features grow
5. **`auth` adapter** (A-1) — most requested backend feature, high adoption signal
6. **Graceful shutdown everywhere** (X-2, A-7) — production requirement
7. **Standardized error contracts** (X-3, A-8) — consistency before breaking changes
8. **CI/CD for all projects** (X-7) — quality gate
9. **WebSocket push in ServConsole** (Q-3) — makes the dashboard feel production-grade
10. **Remaining adapters** (A-2 through A-6) — widen addressable audience

---

## 11. Next-Level Roadmap — Taking Each Component to Category-Defining Status

The items below go beyond operational hardening. They represent the features that would make each Servverse component a **differentiated product** in its category — not just functional, but best-in-class.

### 🚀 Serv-lang → Category-Defining Service Language

| # | Feature | Why It Matters |
|---|---------|----------------|
| 14.1 | **Compile-time dependency injection** | Testable architectures without runtime reflection — Dagger.io-style but at compile time |
| 14.2 | **Hot-reload without restart** | Zero-downtime local dev. Currently need full recompile + restart. `serv run --hot` with socket handoff. |
| 14.3 | **OpenAPI auto-generation** | `serv docs generate` → complete OpenAPI 3.1 from route declarations. Instant API documentation. |
| 14.4 | **Client SDK generation** | `serv generate client --lang typescript` — typed API clients from route types. No OpenAPI intermediary. |
| 14.5 | **Incremental compilation** | Cache per-file artifacts. Only recompile changed files. Critical at scale (>50 files). |
| 14.6 | **`pipe` operator** | `data |> transform() |> validate() |> save()` — readable data pipelines. Low cost, high readability. |
| 14.7 | **Streaming response support** | `route ... stream { yield ... }` — SSE/chunked as first-class route type. Enables real-time UIs. |
| 14.8 | **GraphQL endpoint declaration** | Native GraphQL schema + resolver syntax. Compiles to performant Go handler. |
| 14.9 | **Language server code actions** | Quick-fix: "Extract function", "Add error handling", "Generate test stub". Active refactoring assistance. |
| 14.10 | **Compile-time macros** | `@derive(Serialize, Validate)` — generate boilerplate at compile time. Reduces repetitive code. |

### 🛡️ ServGate → Category-Defining API Gateway

| # | Feature | Why It Matters |
|---|---------|----------------|
| 9.1 | **OpenAPI auto-discovery** | Serve auto-generated API docs from registered routes at `/api/docs`. |
| 9.2 | **Developer portal** | Embedded interactive API explorer. Try endpoints directly with auth injection. |
| 9.4 | **Multi-tenant API key management** | Issue/rotate/revoke keys per tenant with per-key rate limits and analytics. |
| 9.5 | **Canary/blue-green traffic splitting** | Route % of traffic to new version. Gradual rollouts without service mesh. |
| 9.6 | **Request validation (JSON Schema)** | Reject malformed requests at gateway. Never hits backend. |
| 9.8 | **GraphQL federation proxy** | Route GraphQL queries to multiple backends, merge schemas. Supergraph router. |
| 9.12 | **Mutual TLS (mTLS)** | Client cert auth to backends. Zero-trust service-to-service. |
| 9.13 | **Request queuing & backpressure** | Queue when overloaded, apply 429/503 with Retry-After. Prevents cascades. |

### 📨 ServQueue → Category-Defining Event Streaming Platform

| # | Feature | Why It Matters |
|---|---------|----------------|
| 9.1 | **Exactly-once delivery** | Idempotent producers + transactional batches. Gold standard for financial systems. |
| 9.2 | **Schema registry & validation** | Reject non-conforming publishes. Auto-evolve schemas with compatibility checks. |
| 9.5 | **Stream processing DSL** | Windowed aggregations in `.srv` syntax. Compete with Kafka Streams/Flink without external infra. |
| 9.6 | **Message replay with offset management** | Named consumer offsets with commit/seek. Replay from any WAL point. |
| 9.9 | **Cross-cluster mirroring** | Replicate topics between geo-separate clusters. DR and active-active. |
| 9.10 | **Message tracing (end-to-end journey)** | Track a message from publish through transforms, DLQ, and consumer ack. Visualize in ServConsole. |
| 9.11 | **WASM transform marketplace** | Install transforms from ServRegistry. Pre-built: JSON→Protobuf, PII masking. |

### 💾 ServStore → Category-Defining Intelligent Storage

| # | Feature | Why It Matters |
|---|---------|----------------|
| 9.1 | **Multi-modal embedding engine** | Auto-embed images (CLIP), PDFs, audio (Whisper) on ingest. Semantic search across all content types. |
| 9.2 | **Vector + metadata hybrid queries** | Combine semantic search with structured filters in one call. Unique differentiator. |
| 9.5 | **S3 event notifications (CloudEvents)** | Emit lifecycle events to webhooks or ServQueue. Enables event-driven architectures. |
| 9.6 | **Geo-aware data placement** | Region-tagged nodes with policy-driven replication. Reads routed to nearest replica. |
| 9.10 | **WASM trigger on object events** | Lambda@S3-style triggers inside the storage engine. Zero-latency event processing. |
| 9.12 | **Content-type aware compression** | Auto-compress text/JSON with zstd on write. Transparent decompress on read. |
| 9.14 | **Federation (cross-cluster namespace)** | Global bucket names resolve to owning cluster. Like DNS for objects. |

### 🖥️ ServConsole → Category-Defining Observability Platform

| # | Feature | Why It Matters |
|---|---------|----------------|
| 7.1 | **Alerting engine & notifications** | Alert rules with Slack/PagerDuty/webhook channels. Snooze/ack workflow. |
| 7.2 | **Incident timeline auto-generation** | Auto-build timeline on alert: deploys, metric spikes, error traces. One-page summary. |
| 7.3 | **Service topology auto-discovery** | Parse OTel spans → dependency graph. Show latency and error rates on edges. |
| 7.4 | **Log aggregation & search** | Collect JSON logs, full-text search, filter by service/level/trace_id. Live tail. |
| 7.5 | **Custom dashboard builder** | Drag-and-drop: pick metrics, choose chart type, save and share per team. |
| 7.7 | **SLO/SLI tracking & error budgets** | Define SLOs, track remaining budget, alert when burning too fast. |
| 7.12 | **Runbook automation** | Attach remediation steps to alerts. Auto-execute: restart, scale, clear cache. |

---

## 12. Differentiating Factors — The Servverse Moat

The Servverse's competitive advantage is NOT individual component features — it's the **tight integration between compiler, infrastructure, and observability** that no competitor can replicate without rebuilding from scratch. Below are the key moat-building differentiators per component.

### Core Thesis: "The compiler is the platform"

Unlike competitors where language, infrastructure, and observability are independent products bolted together, Servverse's compiler has **complete knowledge** of what a service needs. This enables:
- Zero-config deployment (infra inferred from source)
- Zero-config observability (tracing injected by compiler)
- Zero-config service discovery (routes self-announce to gateway)
- Zero-config schema safety (types checked across service boundaries)

### Per-Component Differentiators

#### Serv-lang — "The Compiler Knows Everything"
| Differentiator | Compared To | Moat Strength |
|----------------|-------------|---------------|
| Infra requirements inferred from source code — `database` → emits PVC in k8s YAML | Terraform/Pulumi require manual config | 🔒🔒🔒 |
| Zero-config distributed tracing — compiler inserts OTel spans into every handler | Go/Java/Python need manual SDK instrumentation | 🔒🔒🔒 |
| Cross-service type safety via `.srv.d` declarations | OpenAPI + codegen is multi-step and fragile | 🔒🔒 |
| AI-assisted compilation — LLM generates handler bodies from docstrings at build time | GitHub Copilot works at edit-time, not compile-time | 🔒🔒🔒 |
| MCP tool + REST endpoint from single `tool` declaration | Every other framework needs separate MCP adapter | 🔒🔒 |
| Compile-time chaos testing — `serv test --chaos` injects failures at known infra callsites | External chaos tools (Gremlin, Litmus) are runtime-only | 🔒🔒 |
| Infra-aware dead code elimination — unused runtime modules excluded from binary | No general-purpose compiler can tree-shake by infra declaration | 🔒🔒🔒 |

#### ServGate — "The AI-Native Programmable Gateway"
| Differentiator | Compared To | Moat Strength |
|----------------|-------------|---------------|
| WASM middleware hot-swap without request drops | Envoy needs pod restart; Kong needs reload | 🔒🔒🔒 |
| Compiler-aware route registration (zero-config from `.srv` source) | Every other gateway needs manual route config or service mesh | 🔒🔒🔒 |
| Semantic API caching (embedding similarity, not URL match) | No competitor has AI-aware cache matching | 🔒🔒🔒 |
| Policy-as-code compiled to WASM (native speed, not interpreted) | OPA/Rego is interpreted; ServGate compiles policies | 🔒🔒 |
| MCP-native gateway (AI agent routing, token tracking) | 2026 trend — ServGate can be first movers here | 🔒🔒 |
| Cost-aware LLM routing (cheapest model meeting quality SLA) | No gateway product offers model cost optimization | 🔒🔒🔒 |
| Inline PII detection before logging | Most gateways log everything; redaction is afterthought | 🔒 |

#### ServQueue — "Compute-in-Queue"
| Differentiator | Compared To | Moat Strength |
|----------------|-------------|---------------|
| WASM transforms inside the message path (no external processor) | Kafka Streams = separate JVM app; Flink = separate cluster | 🔒🔒🔒 |
| Single binary deployment (STOMP + HTTP + WASM + WAL + Raft) | Kafka = JVM + ZooKeeper; RabbitMQ = Erlang; Pulsar = JVM + BookKeeper | 🔒🔒🔒 |
| Trace context survives through transform chains | Most brokers lose context between producer/consumer | 🔒🔒 |
| Real-time WASM hot-swap without dropping connections | Kafka Streams requires rebalancing; Flink needs savepoint | 🔒🔒🔒 |
| Integrated cold-tier to ServStore (infinite retention at S3 cost) | Kafka Tiered Storage needs separate S3 config | 🔒🔒 |
| Language-native STOMP driver from `.srv` code (zero SDK) | Every other broker needs manual client library import | 🔒🔒 |
| AI-powered semantic routing (future) | No broker routes by message meaning — all use exact topic match | 🔒🔒🔒 |

#### ServStore — "AI-Native Intelligent Storage"
| Differentiator | Compared To | Moat Strength |
|----------------|-------------|---------------|
| Semantic search on stored objects (auto-embedded on ingest) | AWS S3 Vectors (GA Dec 2025) is similar but separate feature; MinIO has nothing | 🔒🔒🔒 |
| WASM compute-near-data (transform objects server-side, zero cold start) | AWS Lambda@S3 = 100ms+ cold start + separate infra; MinIO = no compute | 🔒🔒🔒 |
| Time travel queries (state at any timestamp, not just version IDs) | S3 requires manual version listing + filtering | 🔒🔒 |
| Multi-stage WASM pipeline DAG (chain transforms) | AWS needs Step Functions + Lambda + S3 events (3 services) | 🔒🔒🔒 |
| CAS with reference-counted GC | Unique — most storage engines don't do content-addressed dedup with GC | 🔒🔒 |
| Cold-tier with transparent rehydration (no restore delay) | AWS Glacier = hours of restore time; ServStore = instant on first access | 🔒🔒🔒 |
| Unified: Store + Search + Compute in one binary | Nobody unifies S3 + vector DB + serverless in one engine | 🔒🔒🔒 |

#### ServConsole — "The Ecosystem Control Plane"
| Differentiator | Compared To | Moat Strength |
|----------------|-------------|---------------|
| Zero-config integration with all Servverse services | Grafana needs: exporters + dashboards + alerting per service | 🔒🔒🔒 |
| WASM hot-swap from the dashboard (bidirectional control) | Grafana/Datadog are read-only dashboards | 🔒🔒🔒 |
| Hash ring visualization (distributed storage internals) | No generic dashboard understands consistent hashing | 🔒🔒 |
| Compiler-linked schema viewer (ORM output from `.srv` source) | Other tools reverse-engineer schema from DB; this comes from compiler | 🔒🔒 |
| Single binary, zero-dependency | Grafana = PostgreSQL + provisioning; Datadog = SaaS-only | 🔒🔒 |
| Cross-service trace waterfall (auto-correlated) | Possible in Tempo/Jaeger but requires manual instrumentation | 🔒🔒 |

### The Integration Moat (Hardest to Replicate)

The most defensible differentiator isn't any single feature — it's the **integration density**:

```
Developer writes .srv code
    ↓ Compiler generates Go binary WITH:
        • OTel spans pre-inserted (zero-config tracing)
        • ServGate self-registration (zero-config routing)
        • ServQueue auto-connect (zero-config messaging)
        • Resource profile emitted (zero-config k8s sizing)
    ↓ Binary runs and:
        • ServConsole auto-discovers it (zero-config dashboard)
        • ServGate routes traffic to it (zero-config ingress)
        • ServQueue delivers messages (zero-config pub/sub)
        • ServStore persists data (zero-config storage)
```

This "write code → everything works" experience is the **fundamental differentiator**. It requires owning the compiler, the infrastructure, and the observability layer simultaneously. No competitor owns all three.

---

*This document is the canonical Serv ecosystem roadmap. Individual project ROADMAP.md files link back to specific phases tracked here.*
