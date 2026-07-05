# ServCron — Distributed Job Scheduler

> **Status:** ✅ Production | **Port:** 8085 | **Repository:** [ServCron](https://github.com/vyuvaraj/ServCron)

## Overview

ServCron is a distributed scheduling service with Redis lease-based leader election, cron pattern parsing, ServStore persistence for job definitions, REST APIs for management, and OpenTelemetry tracing for job execution visibility.

## Key Features

- Redis lease-based leader election for HA scheduling
- Standard cron pattern parsing (5-field and extended)
- Interval-based scheduling (`every` syntax)
- ServStore persistence for job definitions
- REST APIs for job CRUD and manual triggers
- OpenTelemetry tracing per job execution
- Distributed lock to prevent duplicate runs

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVCRON_PORT` | HTTP listen port | `8085` |
| `SERVCRON_REDIS_URL` | Redis URL for leader election | (required) |
| `SERVSTORE_URL` | ServStore URL for job persistence | (required) |
| `SERV_OTLP_ENDPOINT` | OTel collector URL | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `GET /api/v1/jobs` | List all scheduled jobs |
| `POST /api/v1/jobs` | Create a new job |
| `POST /api/v1/jobs/{id}/run` | Manually trigger a job |
| `DELETE /api/v1/jobs/{id}` | Delete a job |

## Serv-lang Integration

```srv
every "5m" {
    // runs every 5 minutes
}

cron "0 9 * * MON-FRI" {
    // runs at 9am on weekdays
}
```
