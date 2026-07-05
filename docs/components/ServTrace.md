# ServTrace — Distributed Tracing Backend

> **Status:** ✅ Production | **Port:** 8090 | **Repository:** [ServTrace](https://github.com/vyuvaraj/ServTrace)

## Overview

ServTrace is a lightweight OTLP/HTTP distributed tracing backend. It reconstructs hierarchical trace trees, renders waterfall UI visualizations, performs span anomaly detection, archives cold-tier data to ServStore, and supports configurable sampling policies.

## Key Features

- OTLP/HTTP span ingestion (OpenTelemetry native)
- Hierarchical trace tree reconstruction
- Waterfall UI for trace visualization
- Span duration anomaly detection
- Cold-tier archival to ServStore
- Configurable sampling policies (head/tail)
- Trace search by service, operation, and duration
- Span tag indexing for fast lookups

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVTRACE_PORT` | HTTP listen port | `8090` |
| `SERVSTORE_URL` | ServStore URL for cold storage | (required) |
| `SERV_OTLP_ENDPOINT` | OTel collector for self-tracing | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `POST /v1/traces` | OTLP trace ingestion endpoint |
| `GET /api/v1/traces` | Search and list traces |
| `GET /api/v1/traces/{id}` | Get full trace detail with spans |

## Serv-lang Integration

```srv
otel "my-service"
// automatic tracing — all routes and outbound calls are instrumented
```
