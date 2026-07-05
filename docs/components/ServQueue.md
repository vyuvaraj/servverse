# ServQueue — WASM-Enabled Message Broker

> **Status:** ✅ Production | **Port:** 8082 (HTTP) / 61613 (STOMP) | **Repository:** [ServQueue](https://github.com/vyuvaraj/ServQueue)

## Overview

Distributed STOMP-compliant message broker with inline WASM transforms, WAL persistence, tiered storage to ServStore, and Raft clustering. Single binary.

## Key Features

- STOMP TCP protocol (CONNECT, SUBSCRIBE, SEND)
- HTTP management API for publishing and admin
- WASM sandbox for inline message transforms (wazero)
- Dead letter queues (auto-route failed messages)
- Delayed and scheduled messages
- Message deduplication (sliding window)
- Consumer groups with partition assignment
- Message priority levels
- Exactly-once delivery semantics
- Schema registry and validation
- Topic compaction (latest-per-key retention)
- Write-ahead log (WAL) for durability
- Cold data offload to ServStore (infinite retention)
- Log replay from any offset or timestamp
- Raft-backed clustering with partition management
- Cross-cluster mirroring
- Backpressure and flow control
- Message TTL and expiration
- WASM hot-swap without dropping connections
- OTel trace propagation through transforms

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVQUEUE_PORT` | HTTP API port | `8082` |
| `SERVQUEUE_STOMP_PORT` | STOMP TCP port | `61613` |
| `SERV_JWT_SECRET` | Auth token secret | (optional) |
| `SERV_OTLP_ENDPOINT` | OTel collector | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `POST /api/v1/publish` | Publish message to topic |
| `GET /api/v1/topics` | List topics |
| `POST /api/v1/wasm/upload` | Upload WASM transform |

## Serv-lang Integration

```srv
broker "servqueue://localhost:61613"

publish "orders.new" { "id": orderId, "total": amount }

subscribe "orders.new" (msg) {
    processOrder(msg)
}
```
