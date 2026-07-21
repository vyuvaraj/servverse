# ServTunnel — Secure Dev Tunneling

> **Status:** ✅ Production | **Port:** 8443 | **Repository:** [ServTunnel](https://github.com/vyuvaraj/serv/tree/main/packages/ServTunnel)

## Overview

ServTunnel provides secure development tunneling with WebSocket relay, subdomain-based routing, request inspection, TLS termination, custom domain support, and OpenTelemetry propagation for end-to-end observability through tunnels.

## Key Features

- WebSocket-based relay for low-latency tunneling
- Subdomain routing (unique URL per tunnel)
- Request/response inspection and replay
- TLS termination at the edge
- Custom domain mapping
- OpenTelemetry context propagation through tunnels
- Automatic reconnection on network interruption
- Rate limiting per tunnel

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVTUNNEL_PORT` | HTTPS listen port | `8443` |
| `SERVTUNNEL_DOMAIN` | Wildcard domain for tunnels | `*.servverse.net` |
| `SERV_OTLP_ENDPOINT` | OTel collector URL | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `GET /readyz` | Readiness probe |
| `GET /api/inspect` | View request inspection log |
| `POST /api/inspect/{id}/replay` | Replay a captured request |

## Serv-lang Integration

```srv
serv tunnel 8080
// → public HTTPS URL: https://<subdomain>.servverse.net
```
