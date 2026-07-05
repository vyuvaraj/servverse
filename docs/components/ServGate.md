# ServGate — Programmable API Gateway

> **Status:** ✅ Production | **Port:** 8080 | **Repository:** [ServGate](https://github.com/vyuvaraj/ServGate)

## Overview

ServGate is a WASM-programmable reverse proxy and API gateway with AI-native capabilities. Single binary, zero external dependencies.

## Key Features

- Path-based reverse proxying with route prefix stripping
- WASM middleware hot-swap (zero-downtime deploys)
- WASM response filters and transform pipelines
- gRPC-Web gateway transpilation
- WebSocket proxying
- Load balancing (round-robin, least-connections)
- TLS termination with native HTTPS
- Sliding-window rate limiting
- Circuit breakers with automatic retries
- MCP (Model Context Protocol) native gateway
- Cost-aware LLM routing (cheap model → premium escalation)
- Semantic API caching (embedding-based)
- AI prompt guard and PII redaction
- OpenAPI auto-discovery from registered routes
- Developer portal (interactive API playground)
- Multi-tenant API key management
- Canary/blue-green traffic splitting
- JSON Schema request validation
- GraphQL federation proxy
- IP allowlisting/blocklisting
- Mutual TLS (mTLS) for backends
- Request queuing and backpressure

## Configuration

```json
{
  "addr": ":8080",
  "auth_token": "gateway-secret-token",
  "routes": [
    { "prefix": "/api/users", "target": "http://localhost:3000" },
    { "prefix": "/api/orders", "target": "http://localhost:3001", "rate_limit_rpm": 100 }
  ]
}
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERV_JWT_SECRET` | JWT verification secret | (required) |
| `SERV_OTLP_ENDPOINT` | OTel collector URL | (disabled) |
| `SERVGATE_CONFIG` | Path to config.json | `./config.json` |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `GET /readyz` | Readiness probe |
| `GET /api/v1/routes` | List registered routes |
| `POST /api/v1/routes/register` | Dynamic route registration |
| `POST /api/v1/middleware/upload` | Upload WASM middleware |
| `GET /api/docs` | Interactive API playground |

## Serv-lang Integration

```srv
server "8080"
// Routes auto-register with ServGate on startup via /api/v1/routes/register
```
