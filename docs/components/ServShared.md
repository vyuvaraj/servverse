# ServShared — Common Service Library

> **Status:** ✅ Production | **Used by:** All Servverse services | **Repository:** [ServShared](https://github.com/vyuvaraj/ServShared)

## Overview

ServShared is the common Go library imported by all Servverse services. It provides standardized health probes (`/healthz`, `/readyz`), OpenTelemetry tracer initialization, JWT authentication middleware, structured JSON logging, and service token generation utilities.

## Key Features

- Standardized `/healthz` and `/readyz` probe handlers
- OpenTelemetry tracer initialization with OTLP export
- JWT authentication middleware (verify + extract claims)
- Structured JSON logging with request correlation
- Service-to-service token generation
- User token generation with configurable claims
- Graceful shutdown helpers
- Common error response formatting

## Key Exports

| Export | Description |
|--------|-------------|
| `HealthzHandler` | HTTP handler for liveness probes |
| `ReadyzHandler` | HTTP handler for readiness probes |
| `InitTrace()` | Initialize OpenTelemetry tracer |
| `AuthMiddleware()` | JWT verification middleware |
| `GenerateServiceToken()` | Create service-to-service JWT |
| `GenerateUserToken()` | Create user-scoped JWT |

## Usage

ServShared is not a standalone service — it is imported as a Go module by all Servverse services.

```go
import "github.com/vyuvaraj/ServShared/pkg/shared"

// Health probes
mux.HandleFunc("/healthz", shared.HealthzHandler)
mux.HandleFunc("/readyz", shared.ReadyzHandler)

// OTel init
shutdown := shared.InitTrace("my-service")
defer shutdown(ctx)

// Auth middleware
protected := shared.AuthMiddleware()(handler)
```
