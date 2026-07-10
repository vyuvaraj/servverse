# Servverse Documentation

> The complete reference for the Serv ecosystem — language, components, operations, and architecture.

---

## Getting Started

| Doc | Description |
|-----|-------------|
| [Getting Started](getting-started.md) | Install Serv, write your first service, run it |
| [Language Guide](language-guide.md) | Full language tutorial — 30 sections covering all features |
| [Examples](examples.md) | Categorized code examples with explanations |

---

## Reference

| Doc | Description |
|-----|-------------|
| [Language Reference](language-reference.md) | Detailed syntax specification and type system |
| [Built-in Functions](builtins.md) | `log`, `db`, `cache`, `http`, `json`, `ai`, `store`, `broker` |
| [Standard Library](stdlib.md) | 48 importable `.srv` modules (auth, jwt, retry, pagination, etc.) |
| [CLI Reference](cli.md) | All `serv` commands with flags and usage |

---

## Components

| Doc | Description |
|-----|-------------|
| [Component Catalog](components/README.md) | All 16 services with status, ports, and architecture |
| [ServGate](components/ServGate.md) | API Gateway — WASM middleware, AI routing, MCP support |
| [ServStore](components/ServStore.md) | Object Storage — S3-compatible, semantic search, time-travel |
| [ServQueue](components/ServQueue.md) | Message Broker — STOMP, WASM transforms, DLQ, tiered storage |
| [ServConsole](components/ServConsole.md) | Dashboard — unified observability, SQL workbench, alerting |
| [ServMesh](components/ServMesh.md) | Service Mesh — library-level, mTLS, circuit breaking |
| [ServCache](components/ServCache.md) | Cache — Redis/in-memory, namespacing, TTL |
| [ServCron](components/ServCron.md) | Scheduler — leader election, cron syntax, ServStore persistence |
| [ServCloud](components/ServCloud.md) | Deployment — process orchestration, Docker, gateway sync |
| [ServTrace](components/ServTrace.md) | Tracing — OTLP ingestion, waterfall UI, anomaly detection |
| [ServTunnel](components/ServTunnel.md) | Tunneling — WebSocket relay, request inspection, subdomain routing |
| [ServAuth](components/ServAuth.md) | Identity — OAuth2/OIDC, MFA, RBAC, social login |
| [ServPool](components/ServPool.md) | Database Proxy — pooling, routing, query analytics |
| [ServMail](components/ServMail.md) | Notifications — SMTP, Slack, SMS, templates |
| [ServFlow](components/ServFlow.md) | Workflows — DAG execution, sagas, approval gates |
| [ServRegistry](components/ServRegistry.md) | Packages — semver resolution, signing, ServStore backend |
| [ServDocs](components/ServDocs.md) | Documentation — auto-generated from `.srv` source |
| [ServShared](components/ServShared.md) | Common Library — health probes, OTel, JWT middleware |

---

## Operations

| Doc | Description |
|-----|-------------|
| [Deployment Guide](deployment.md) | Docker, TLS, multi-target deploy, production config |
| [Docker Compose Guide](docker-guide.md) | Run the full 16-service stack locally |
| [Architecture](architecture.md) | Runtime dependencies, service interactions, layers |
| [Roadmap](../UNIFIED_ROADMAP.md) | What's done, what's next, maturity matrix |

---

## Port Allocation

| Service | Port | Protocol |
|---------|------|----------|
| ServGate | 8080 | HTTP/HTTPS |
| ServStore | 8081 | HTTP (S3) |
| ServQueue | 8082 / 61613 | HTTP + STOMP |
| ServConsole | 8083 | HTTP |
| ServCache | 8084 | HTTP |
| ServCron | 8085 | HTTP |
| ServCloud | 8086 | HTTP |
| ServMesh | 8087 | HTTP |
| ServRegistry | 8088 | HTTP |
| ServDocs | 8089 | HTTP |
| ServTrace | 8090 | HTTP (OTLP) |
| ServMail | 8094 | HTTP |
| ServFlow | 8096 | HTTP |
| ServPool | 8097 | HTTP |
| ServAuth | 8098 | HTTP |
| ServTunnel | 8443 | WebSocket |
