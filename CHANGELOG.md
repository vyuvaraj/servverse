# Changelog

All notable changes to the Servverse background service ecosystem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.2.0] - 2026-06-30

### Added
* **SEC.8**: KMS Secrets Envelope Key Rotation worker and SHA-256 API key hashing in `ServAuth`.
* **CORE.1**: HNSW Vector Search Graph implementation and comparative performance benchmark in `ServStore`.
* **PS.1**: Dynamic Connection Pool Tuning (adaptive limit scaling and stale connection invalidation janitor) in `ServDB` and `ServCache`.
* **DX.8**: Regular expression matching support with substring fallback in `ServConsole` live log tailing.
* **PS.2**: WASM Memory Optimization (Wazero directory compilation caching and stateless guest module instance recycling) in `ServGate` and `ServQueue`.
* **SEC.7**: Automated zero-downtime mTLS certificate rotation utilizing dynamic TLS callbacks in `ServMesh`.
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
