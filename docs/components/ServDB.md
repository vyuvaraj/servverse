# ServDB — Database Proxy & Connection Pooler

> **Status:** 🟡 Stable | **Port:** 8097 | **Repository:** [ServDB](https://github.com/vyuvaraj/ServDB)

## Overview

ServDB is a database proxy with connection pooling, read/write query routing, slow query detection, multi-dialect support (SQLite, PostgreSQL, Oracle, MongoDB), and query caching via ServCache for frequently executed queries.

## Key Features

- Connection pooling with configurable pool sizes
- Automatic read/write query routing (primary/replica)
- Slow query detection and logging
- Multi-dialect support: SQLite, PostgreSQL, Oracle, MongoDB
- Query result caching via ServCache integration
- Prepared statement management
- Query metrics and pool statistics
- Health-aware connection recycling

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | HTTP listen port | `8097` |
| `SERVDB_PRIMARY_DSN` | Primary database connection string | (required) |
| `SERVDB_REPLICA_DSN` | Read replica connection string | (optional) |
| `SERVCACHE_URL` | ServCache URL for query caching | (optional) |
| `SERV_OTLP_ENDPOINT` | OTel collector URL | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `POST /api/v1/query` | Execute a SQL/NoSQL query |
| `GET /api/v1/pool/stats` | Connection pool statistics |
| `GET /api/v1/slow-queries` | List detected slow queries |

## Serv-lang Integration

```srv
database "servdb://pool/mydb"
```
