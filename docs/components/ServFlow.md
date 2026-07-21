# ServFlow — Workflow Orchestrator

> **Status:** 🟡 Stable | **Port:** 8096 | **Repository:** [ServFlow](https://github.com/vyuvaraj/serv/tree/main/packages/ServFlow)

## Overview

ServFlow is a workflow orchestrator with DAG-based execution, durable checkpointing, saga compensation and rollback, human approval gates, and event-triggered execution via ServQueue for building complex multi-step business processes.

## Key Features

- DAG-based workflow execution engine
- Durable checkpointing for crash recovery
- Saga pattern with compensation/rollback steps
- Human approval gates with timeout escalation
- Event-triggered workflows via ServQueue
- Parallel step execution within DAG levels
- Workflow versioning and migration
- Execution history and audit trail

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | HTTP listen port | `8096` |
| `SERVSTORE_URL` | ServStore URL for state persistence | (required) |
| `SERVQUEUE_URL` | ServQueue URL for event triggers | (required) |
| `SERV_OTLP_ENDPOINT` | OTel collector URL | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `POST /api/v1/workflows` | Create a workflow definition |
| `GET /api/v1/workflows/{id}` | Get workflow definition |
| `POST /api/v1/workflows/{id}/approve` | Approve a pending gate |
| `GET /api/v1/executions` | List workflow executions |

## Serv-lang Integration

```srv
// Native workflow block syntax in .srv files
workflow "order-fulfillment" {
    step "validate" { ... }
    step "charge" { compensate { ... } }
    step "ship" { ... }
}
```
