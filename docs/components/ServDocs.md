# ServDocs — Documentation Generator

> **Status:** 🟡 Beta | **Port:** 8089 | **Repository:** [ServDocs](https://github.com/vyuvaraj/ServDocs)

## Overview

ServDocs is a documentation generator that parses `.srv` source files to extract routes, types, and infrastructure declarations. It outputs interactive HTML documentation and OpenAPI 3.0 specifications for all discovered API endpoints.

## Key Features

- Automatic parsing of `.srv` source files
- Route extraction with parameter and response documentation
- Type and struct documentation generation
- Infrastructure declaration discovery
- Interactive HTML docs UI
- OpenAPI 3.0 spec generation
- Live reload during development
- Markdown annotation support in source comments

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVDOCS_PORT` | HTTP listen port | `8089` |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `GET /` | Generated documentation UI |

## Serv-lang Integration

```srv
serv doc <file.srv>
```
