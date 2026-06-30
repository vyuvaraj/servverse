# Changelog

All notable changes to the Servverse background service ecosystem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
