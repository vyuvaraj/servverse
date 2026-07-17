# Completed Initiatives (Phases 31-35 Archive)

This document archives completed initiatives for reference, keeping the main roadmap lean.

## Phase 32: ServLock & ServSecret Standalone & Hardening (Completed)

> **Goal:** Support zero-dependency standalone execution modes for both components and implement enterprise-grade security and transport hardening.

### ServLock Standalone & Hardening

| # | Item | Description | Status |
|---|------|-------------|--------|
| SL.6 | **Zero-Dependency Standalone Mode** | Support loading standalone server configuration from `servlock.yaml` (ports, backends) without requiring mesh/shared auth | [x] |
| SL.7 | **API Key Authentication** | Implement API Key token header authorization for standalone clients to access the locking APIs securely | [x] |
| SL.8 | **Lease Event Pub/Sub** | Implement SSE (Server-Sent Events) or WebSocket channels for lock release notifications to eliminate polling | [x] |
| SL.9 | **TLS & mTLS Transport Hardening** | Support native TLS and mutual TLS server configs inside the binary for secure client connection tunnels | [x] |

### ServSecret Standalone & Hardening

| # | Item | Description | Status |
|---|------|-------------|--------|
| SS.6 | **Zero-Dependency Standalone Mode** | Support loading config from `servsecret.yaml` (storage path, encryption schemes, cache rules, auth keys) | [x] |
| SS.7 | **Automated Backup & Recovery** | Configure automated scheduled encrypted backups of the secrets database to local storage or S3/MinIO objects | [x] |
| SS.8 | **Dynamic Environment Injector** | Create helper command `servsecret env run --cmd "app"` to fetch secrets and inject them directly to child processes | [x] |
| SS.9 | **Key Rotation Schedules** | Support background rotation of the master key on a configurable period (e.g. 90 days) with backup keys retention | [x] |

## Phase 33: ServLock & ServSecret Advanced Capabilities (Completed)

> **Goal:** Enhance `ServLock` and `ServSecret` with advanced operational, architectural, and security capabilities.

### ServLock Advanced Capabilities

| # | Item | Description | Status |
|---|------|-------------|--------|
| SL.10 | **Active Heartbeat-Based Lease Extensions** | Automatic lease renewals based on client connection heartbeat pings | [x] |
| SL.11 | **Consensus-Based Clustering with Raft** | support local distributed clustering using Raft consensus mechanism | [x] |
| SL.12 | **Dynamic Waiter Priority Queues** | Allow lock waiters to specify priority levels to bypass standard FIFO queues | [x] |
| SL.13 | **Lease Hold-Time Alerting** | Monitor lease durations and alert on zombie locks held past threshold | [x] |
| SL.14 | **Read-Only Shared Locks** | Implement shared (read) and exclusive (write) multi-access locking | [x] |

### ServSecret Advanced Capabilities

| # | Item | Description | Status |
|---|------|-------------|--------|
| SS.10 | **Secret Versioning and Rollbacks** | Maintain a timeline of secret revisions allowing rollout rollback | [x] |
| SS.11 | **Dynamic Database Credentials** | Just-In-Time generation of short-lived database user logins | [x] |
| SS.12 | **Client-Side Zero-Knowledge Decryption** | Secure mode keeping the master decryption key strictly client-side | [x] |
| SS.13 | **IP CIDR & Geofencing Policies** | Restrict secret lookups by network subnets or geofenced zones | [x] |
| SS.14 | **Secret Leak Detection & Scanning** | Scan payloads/logs to flag plaintext exposure of managed secrets | [x] |
