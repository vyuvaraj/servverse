# ServCache — Distributed Caching Layer

> **Status:** ✅ Production | **Port:** 8084 | **Repository:** [ServCache](https://github.com/vyuvaraj/ServCache)

## Overview

ServCache is a distributed cache with pluggable Redis and in-memory adapters. It provides automatic key namespacing, TTL-based eviction, and full OpenTelemetry tracing for cache operations.

## Key Features

- Redis and in-memory storage adapters
- Automatic key namespacing per service
- TTL-based eviction with configurable expiry
- OpenTelemetry tracing on all cache operations
- Bulk get/set operations
- Cache invalidation via REST API
- Namespace-scoped clear operations

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVCACHE_PORT` | HTTP listen port | `8084` |
| `SERVCACHE_REDIS_URL` | Redis connection URL | (in-memory fallback) |
| `SERV_OTLP_ENDPOINT` | OTel collector URL | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `GET /api/v1/get/{key}` | Retrieve cached value |
| `POST /api/v1/set` | Store value with optional TTL |
| `DELETE /api/v1/delete/{key}` | Delete a cached key |
| `POST /api/v1/clear` | Clear all keys in namespace |

## Serv-lang Integration

```srv
cache "redis://localhost:6379"

cache.set("key", value, "60s")
cache.get("key")
```
