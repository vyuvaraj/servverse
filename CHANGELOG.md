# Changelog

All notable changes to the Servverse background service ecosystem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.3.0] - 2026-07-01

### Added
* **ARCH.5**: Shared package extraction and strict constructor dependency injection in `ServMail`. Handlers are now structured as methods on `MailServer`.
* **DX.9**: Offline mock mode support. Adds a concurrent TCP-based mock SMTP server (listening on port 1025) in `ServMail` and offline S3 mock API mode (activated via `--mock` or `SERVSTORE_MOCK=true`) in `ServStore`.
* **OPS.5**: GitOps configuration sync webhook endpoint `/api/gitops/webhook` and `/api/v1/gitops/webhook` in `ServGate` to pull changes and dynamically reload routes.
* **OPS.6**: Integrated ACME / Let's Encrypt autocert client in `ServGate` supporting port 80 HTTP-01 challenge redirect and automated certificate renewals on port 443.
* **CORE.2**: Durable Sagas rollback engine in `ServFlow` which executes compensation actions (with support for HTTP endpoints), updates intermediate statuses to `"compensating"`, and durably checkpoints state so rollbacks resume on startup.
* **OPS.11**: Performance Regression CI Gates. Integrated PR benchmark gating workflow ([perf-gates.yml](file:///c:/Mine/try/serv/servverse-repo/.github/workflows/perf-gates.yml)) and SLA validators ([verify_perf_sla.py](file:///c:/Mine/try/serv/servverse-repo/scripts/verify_perf_sla.py)) verifying latency (<20ms) and error margins.
* **CORE.3**: Asynchronous Event-Driven Sagas. Implemented STOMP messaging-based saga compensation notifications over `ServQueue` topics and a REST continuation callback API in `ServFlow`.
* **CORE.5**: First-Class Ecosystem Standard Library. Added `cache.srv` and `db.srv`, and updated `auth.srv` and `queue.srv` to export native bindings directly in `serv-lang`.
* **PS.3**: Dynamic Backpressure Routing. Added backpressure load balancer strategy in `ServGate` routing load dynamically away from busy target nodes based on `X-Backpressure` headers.
* **SEC.15**: Dynamic IAM Policy Hot-Reloading. Enabled session revocation and dynamic token refresh signaling via `X-Token-Refresh` responses on stale policy versions in `ServGate`.
* Added a unit test suite testing S3 mock gateways (`TestS3MockMode` in `ServStore`), GitOps webhooks (`TestGitOpsConfigSyncWebhook` in `ServGate`), event-driven saga compensations (`TestEventDrivenSagaCompensation` in `ServFlow`), dynamic backpressure routing (`TestDynamicBackpressureRouting` in `ServGate`), and policy reloading (`TestDynamicIAMPolicyHotReloading` in `ServGate`).

### Fixed
* Fixed base64 URL decoding type mismatch bug in `base64UrlDecode` utility.
* Fixed vendor dependency resolution in `ServFlow` container builds.
* Fixed Printf format verb compilation warning in `Serv-lang` status command ([cmd_status.go](file:///c:/Mine/try/serv/Serv-lang/cmd_status.go)).
* Fixed lint warning on tagged switches for `selected` in `advanced_features_test.go` and `r.Method` in `main.go`.
* Fixed test port collision flakiness in `TestRateLimiting` and `TestDirectMemoryPassingAndResponseFilters` inside `ServGate/main_test.go` by dynamic port reassignment.

---

## [1.2.0] - 2026-06-30

### Added
* **SEC.8**: KMS Secrets Envelope Key Rotation worker and SHA-256 API key hashing in `ServAuth`.
* **CORE.1**: HNSW Vector Search Graph implementation and comparative performance benchmark in `ServStore`.
* **PS.1**: Dynamic Connection Pool Tuning (adaptive limit scaling and stale connection invalidation janitor) in `ServDB` and `ServCache`.
* **DX.8**: Regular expression matching support with substring fallback in `ServConsole` live log tailing.
* **PS.2**: WASM Memory Optimization (Wazero directory compilation caching and stateless guest module instance recycling) in `ServGate` and `ServQueue`.
* **SEC.7**: Automated zero-downtime mTLS certificate rotation utilizing dynamic TLS callbacks in `ServMesh`.
* **OPS.7**: Ecosystem Performance Suite (Go native micro-benchmarks for ServAuth, ServDB, ServMesh, ServGate, and ServQueue).
* **Phase 7 Audit — API Contract Enforcement**: Strict database dialect validation and query placeholder syntax checking in `ServDB`.
* **Phase 7 Audit — Secrets & Token Security**: JWT token expiry assertions, cryptographic hashing of API keys, and automated key rotation schemas.
* **Phase 7 Audit — Multi-Tenancy Enforcement**: Strict tenant isolation across HTTP and STOMP routes with dedicated database and queue pools.
* **Phase 7 Audit — API Versioning**: `/api/v1` API route structure compliance and backward-compatibility validations.

### Fixed
* Resolved flakiness in WebSocket HTTP handshake upgrade tests.
* Fixed file handle leaks and TempDir cleanup failures in `TestS3BatchDelete` operations.
* Corrected log security sanitization to prevent sensitive authorization tokens and session cookies from leaking into standard logs.

---

## [1.1.0] - 2026-06-30

### Added
* **TEST.8**: Go 1.18+ HTTP endpoint fuzzing engine in `ServShared`.
* **TEST.9**: Chaos Recovery and dependency dropout validation E2E integration test.
* **SEC.14**: Tenant switch API `/api/tenant/switch` with JWT session scope rotation in `ServConsole`.
* **API.5**: Response header decoration middleware `DeprecationMiddleware` in `ServShared`.
* **API.6 / DOC.7**: Backward-compatible checking script `check_backward_compat.go`.
* **OPS.9**: Integrated `serv status` command returning metrics and health summaries.
* **DOC.6**: Release-tagger GitHub Action automating semantic release version tagging on branch merges.

### Fixed
* Decomposed console monolith handlers in `ServConsole` into sub-packages cleanly.
* Hardened log output strings from exposing tokens, secrets, and keys.

---

## [1.0.0] - 2026-06-28

### Added
* Initial production release of the Servverse background service ecosystem.
* Shared validation middlewares, JWKS dynamic key verification, and tenant header assertion checks.
