# ServQueue — WASM-Enabled Message Broker

> **Status:** ✅ Production | **Port:** 8082 (HTTP) / 61613 (STOMP) | **Repository:** [ServQueue](https://github.com/vyuvaraj/serv/tree/main/packages/ServQueue)

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

## STOMP Protocol Reference

### 1. Connect
Establishes a connection session with the broker.
```text
CONNECT
accept-version:1.2
host:localhost
login:admin
passcode:password

^@
```
**Response Frame:**
```text
CONNECTED
version:1.2
session:sess-94812b...

^@
```

### 2. Send Message
Publishes a message to a specific topic.
```text
SEND
destination:/topic/orders.new
content-type:application/json
content-length:27

{"id":"order-101","val":99}
^@
```

### 3. Subscribe
Subscribes to a message queue or topic.
```text
SUBSCRIBE
id:sub-0
destination:/topic/orders.new
ack:client-individual

^@
```

---

## Operational Recovery Runbook

### Playbook 1: Write-Ahead Log (WAL) Corruption Recovery
If the broker fails to boot due to checksum errors in the Write-Ahead Log:
1. **Locate WAL Files**: Navigate to the partition WAL store:
   ```bash
   cd /var/lib/servqueue/wal
   ```
2. **Scan and Recover**: Run the log repair tool to isolate corrupted sectors and truncate the WAL to the last valid transaction:
   ```bash
   servqueue-tool repair-wal --wal-dir . --out-dir ./recovered_wal
   ```
3. **Roll Forward**: Restart the service. It will automatically re-index the WAL:
   ```bash
   servqueue-server --wal-dir ./recovered_wal
   ```

### Playbook 2: Dead Letter Queue (DLQ) Purging and Re-routing
If message delivery consistently fails and fills up the DLQ:
1. **Identify the Failure Cause**: Query the schema validation registry or trace log to identify why consumers rejected the payload:
   ```bash
   curl -X GET http://localhost:8082/api/v1/dlq/errors
   ```
2. **Re-route DLQ Messages**: Once consumer issues are resolved, re-enqueue DLQ messages into the active queue:
   ```bash
   curl -X POST http://localhost:8082/api/v1/dlq/requeue \
     -d '{"topic":"orders.new","limit":100}' \
     -H "Authorization: Bearer admin-token"
   ```

