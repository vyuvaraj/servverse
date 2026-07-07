# Servverse Component Catalog

This catalog outlines all 15 operational services of the Servverse ecosystem and their current lifecycle statuses.

## Services Catalog

### 1. Ingress & Edge
* **ServGate**: API Gateway. Handles routing, rate limiting, and transformations.
* **ServTunnel**: Public secure tunnel endpoint for exposing local services.

### 2. Identity & Persistence
* **ServAuth**: OIDC token issuer, key-rotations, and TOTP MFA provider.
* **ServDB**: SQL database proxy manager (SQLite, Postgres, Oracle).
* **ServStore**: S3-compatible persistent object store.

### 3. Messaging & Workloads
* **ServQueue**: WAL-backed message broker (STOMP / HTTP).
* **ServCron**: Cron scheduling control plane.
* **ServFlow**: Sagas and Schedulers DAG Workflow Engine.
* **ServMail**: SMTPTransactional Mail Agent.

### 4. Service Mesh & Utilities
* **ServMesh**: Service registry and client-side load balancer.
* **ServCache**: Redis connection caching wrapper.
* **ServShared**: Shared middleware library.

### 5. Developer Control
* **ServConsole**: Operational UI dashboard.
* **ServDocs**: In-console embedded compiler documentation browser.
* **Serv-lang**: AST compiler compiler target.
