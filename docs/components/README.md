# Serv-verse Component Catalog

> A comprehensive reference for every component in the Serv ecosystem.  
> Last updated: July 5, 2026

---

## Component Status Overview

| Status | Meaning |
|--------|---------|
| ✅ Production | Fully implemented, tested, deployed |
| 🟡 Stable | Functional, pending hardening |
| 🔴 Not Started | Planned, no code yet |

---

## All Components by Layer

### 🛠 Developer Tools

| Component | Status | Description |
|-----------|--------|-------------|
| [ServLang](ServLang.md) | ✅ Production | Compiler and language — the core of everything |
| [ServDocs](ServDocs.md) | 🟡 Stable | Auto-generated documentation from `.srv` source |
| [ServRegistry](ServRegistry.md) | ✅ Production | Package registry for `.srv` modules with semver resolution |
| [ServTunnel](ServTunnel.md) | ✅ Production | Secure dev tunneling with request inspection |
| [ServIDE](ServIDE.md) | 🟡 Stable | VS Code extension with LSP (diagnostics, autocomplete, hover, go-to-def) |
| [ServPlayground](ServPlayground.md) | 🔴 Not Started | Web-based sandbox for instant experimentation |
| [ServSDK](ServSDK.md) | 🔴 Not Started | Auto-generated typed client libraries |

---

### 🏗 Platform Layer

| Component | Status | Description |
|-----------|--------|-------------|
| [ServGateway](ServGateway.md) | ✅ Production | Programmable API gateway with WASM middleware, AI-native routing, MCP support |
| [ServMesh](ServMesh.md) | ✅ Production | Library-level service mesh (no sidecars) with mTLS, circuit breaking, canary routing |
| [ServCloud](ServCloud.md) | ✅ Production | Multi-target deployment orchestrator with WASM isolation and Docker runner |
| [ServConsole](ServConsole.md) | ✅ Production | Unified web dashboard for all services — observability, ops, config |

---

### 🧱 Infrastructure Layer

| Component | Status | Description |
|-----------|--------|-------------|
| [ServStore](ServStore.md) | ✅ Production | S3-compatible object storage with WASM transforms, vector search, time-travel |
| [ServQueue](ServQueue.md) | ✅ Production | Message broker with WASM inline compute, WAL, tiered storage, DLQ |
| [ServCache](ServCache.md) | ✅ Production | Distributed cache with Redis/in-memory adapters, namespacing, OTel |
| [ServDB](ServDB.md) | 🟡 Stable | Database proxy with connection pooling, query routing, analytics |
| [ServAuth](ServAuth.md) | 🟡 Stable | Identity provider with OAuth2/OIDC, MFA, RBAC, social login |
| [ServMail](ServMail.md) | 🟡 Stable | Multi-channel notification provider (SMTP, Slack, SMS, webhooks) |
| [ServCron](ServCron.md) | ✅ Production | Distributed scheduling with Redis leader election, ServStore persistence |
| [ServFlow](ServFlow.md) | 🟡 Stable | Workflow orchestrator with DAG execution, sagas, approval gates |

---

### 📊 Observability Layer

| Component | Status | Description |
|-----------|--------|-------------|
| [ServTrace](ServTrace.md) | ✅ Production | Distributed tracing backend with OTLP ingestion, waterfall UI, anomaly detection |
| [ServShared](ServShared.md) | ✅ Production | Common Go library: health probes, OTel init, JWT middleware, structured logging |

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                       DEVELOPER TOOLS                               │
│  ServLang │ ServIDE │ ServDocs │ ServRegistry │ ServTunnel          │
├─────────────────────────────────────────────────────────────────────┤
│                       PLATFORM LAYER                                │
│  ServGateway │ ServMesh │ ServCloud │ ServConsole                   │
├─────────────────────────────────────────────────────────────────────┤
│                     INFRASTRUCTURE LAYER                            │
│  ServStore │ ServQueue │ ServCache │ ServDB │ ServAuth              │
│  ServMail  │ ServCron  │ ServFlow                                   │
├─────────────────────────────────────────────────────────────────────┤
│                     OBSERVABILITY & FOUNDATION                      │
│  ServTrace │ ServShared                                             │
└─────────────────────────────────────────────────────────────────────┘
```

*Total components: 16 implemented | 2 planned (ServPlayground, ServSDK)*

---

## Service Port Allocation

| Service | Default Port | Protocol |
|---------|-------------|----------|
| ServGate | 8080 | HTTP/HTTPS |
| ServStore | 8081 | HTTP (S3-compatible) |
| ServQueue | 8082 (HTTP) / 61613 (STOMP) | HTTP + TCP |
| ServConsole | 8083 | HTTP |
| ServTrace | 8090 | HTTP (OTLP) |
| ServMail | 8094 | HTTP |
| ServFlow | 8096 | HTTP |
| ServDB | 8097 | HTTP |
| ServAuth | 8098 | HTTP |
| ServCache | 8084 | HTTP |
| ServCron | 8085 | HTTP |
| ServCloud | 8086 | HTTP |
| ServMesh | 8087 | HTTP |
| ServRegistry | 8088 | HTTP |
| ServTunnel | 8443 (relay) | HTTP/WebSocket |
| ServDocs | 8089 | HTTP |

---

## Quick Start

```bash
# Start everything (requires Docker/Podman)
cd servverse-repo
podman compose up --build

# Or run individual services
cd ServGate && go run . --port 8080
cd ServStore && go run . --port 8081
cd ServConsole && go run . --port 8083
```

Open ServConsole at `http://localhost:8083` for the unified dashboard.

---

For runtime dependency diagrams, see [RUNTIME_DEPENDENCIES.md](RUNTIME_DEPENDENCIES.md).  
For the full ecosystem roadmap, see [UNIFIED_ROADMAP.md](../../servverse-repo/UNIFIED_ROADMAP.md).
