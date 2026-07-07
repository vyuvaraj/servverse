# Docker Compose Deployment Guide (Multi-service Production)

This guide documents deploying the complete 15-service ecosystem via Docker Compose, including configuration variables, networking boundaries, and healthcheck mappings.

## Docker Compose Manifest

Create a `docker-compose.yml` to boot core components alongside the newer identity, database, and workflow agents:

```yaml
version: '3.8'

services:
  # ── Core Infrastructure ─────────────────────────────────────────────────────
  serv-store:
    image: servverse/servstore:latest
    ports:
      - "8081:8081"
    environment:
      - PORT=8081
      - DATA_DIR=/data
    volumes:
      - store-data:/data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8081/healthz"]
      interval: 10s

  serv-queue:
    image: servverse/servqueue:latest
    ports:
      - "8082:8082"
    environment:
      - PORT=8082
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8082/healthz"]
      interval: 10s

  # ── Identity & Persistence (Phase 9/10) ─────────────────────────────────────
  serv-auth:
    image: servverse/servauth:latest
    ports:
      - "8098:8098"
    environment:
      - PORT=8098
      - SERV_JWT_SECRET=my-jwt-shared-secret
      - SERV_STORE_URL=http://serv-store:8081
    depends_on:
      - serv-store
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8098/healthz"]
      interval: 10s

  serv-db:
    image: servverse/servdb:latest
    ports:
      - "8097:8097"
    environment:
      - PORT=8097
      - DATABASE_URL=sqlite:///data/app.db
    volumes:
      - db-data:/data
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8097/healthz"]
      interval: 10s

  # ── Workflow Engine & Schedulers ────────────────────────────────────────────
  serv-flow:
    image: servverse/servflow:latest
    ports:
      - "8096:8096"
    environment:
      - PORT=8096
      - SERV_STORE_URL=http://serv-store:8081
    depends_on:
      - serv-store
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8096/healthz"]
      interval: 10s

  serv-mail:
    image: servverse/servmail:latest
    ports:
      - "8094:8094"
    environment:
      - PORT=8094
      - SMTP_HOST=smtp.mailtrap.io
      - SMTP_PORT=2525
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8094/healthz"]
      interval: 10s

  # ── API Gateway & Ingress ───────────────────────────────────────────────────
  serv-gate:
    image: servverse/servgate:latest
    ports:
      - "8080:8080"
    environment:
      - PORT=8080
      - SERV_JWT_SECRET=my-jwt-shared-secret
    depends_on:
      - serv-auth
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/healthz"]
      interval: 10s

volumes:
  store-data:
  db-data:
```

## Security Configurations (TLS / JWT Hardening)

1. **Shared Secret Rotation**: Ensure `$SERV_JWT_SECRET` is synchronized between `serv-auth`, `serv-gate`, and your compiled `serv-lang` backend applications.
2. **mTLS Client Authorization**: Enable server-to-server TLS verification by mounting client certificates inside containers and setting `SERV_MUTUAL_TLS=true` on your service mesh.
