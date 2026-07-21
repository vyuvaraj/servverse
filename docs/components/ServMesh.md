# ServMesh — Library-Level Service Mesh

> **Status:** ✅ Production | **Port:** 8087 | **Repository:** [ServMesh](https://github.com/vyuvaraj/serv/tree/main/packages/ServMesh)

## Overview

ServMesh is a library-level service mesh that eliminates sidecar overhead. It provides service registry, round-robin load balancing, circuit breakers, mTLS between services, canary routing, and OpenTelemetry context propagation — all accessible via the `serv://` URL scheme.

## Key Features

- Service registry with heartbeat-based health tracking
- Round-robin load balancing across service instances
- Circuit breakers with configurable failure thresholds
- Mutual TLS (mTLS) for inter-service communication
- Canary routing with percentage-based traffic splitting
- OpenTelemetry trace context propagation
- Custom `serv://` URL scheme for service-aware requests
- No sidecar containers required — embedded as a library

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERV_JWT_SECRET` | JWT verification secret | (required) |
| `SERV_OTLP_ENDPOINT` | OTel collector URL | (disabled) |
| `SERVMESH_PORT` | HTTP listen port | `8087` |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `POST /api/v1/register` | Register a service instance |
| `GET /api/v1/resolve/{name}` | Resolve service name to address |
| `GET /api/v1/services` | List all registered services |

## Serv-lang Integration

```srv
http.get("serv://user-service/users/123")
```
