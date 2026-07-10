# Getting Started with Serv-lang in 10 Minutes

> **Published:** July 2026 | **Reading Time:** ~10 min | **Tags:** `serv-lang`, `tutorial`, `getting-started`, `go`

---

Serv-lang is a domain-specific language for defining backend services. It compiles to Go and integrates natively with the Servverse ecosystem. By the end of this post, you'll have a working service that handles HTTP routing, validation, caching, and auth — without touching a Kubernetes manifest.

---

## Prerequisites

- Go 1.22+
- Docker (for optional ecosystem services)
- The `serv` CLI

### Install the CLI

**macOS / Linux:**
```bash
curl -sSL https://raw.githubusercontent.com/vyuvaraj/Serv-lang/main/install.sh | bash
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/vyuvaraj/Serv-lang/main/install.ps1 | iex
```

**Verify:**
```bash
serv version
# Serv-lang v0.2.0
```

---

## Step 1: Initialize a New Project

```bash
mkdir my-api && cd my-api
serv init
```

This creates the following structure:

```
my-api/
├── main.srv          # Entry point
├── services/          # Service definitions
├── models/            # Data models
├── serv.yaml          # Project config
└── .serv/             # Build cache
```

---

## Step 2: Define Your First Service

Open `services/user.srv` and add:

```serv
import store
import cache

model User {
  id:       string  @id
  name:     string  @required
  email:    string  @required @unique
  created:  time    @auto
}

service UserService {
  base /api/v1/users

  route GET / {
    auth   required
    cache  ttl=30s  key="users:list"
    return store.list(User)
  }

  route GET /:id {
    auth   required
    cache  ttl=60s  key="users:{id}"
    return store.get(User, id)
  }

  route POST / {
    auth     required
    validate body(User)
    return   store.create(User, body)
  }

  route DELETE /:id {
    auth   required role=admin
    return store.delete(User, id)
  }
}
```

This single file gives you:
- **CRUD endpoints** at `/api/v1/users`
- **JWT authentication** on every route
- **Response caching** with automatic key scoping
- **Body validation** with automatic 400 error responses
- **Role-based access** on the delete route

---

## Step 3: Configure the Project

Edit `serv.yaml`:

```yaml
name: my-api
version: 0.1.0

server:
  port: 3000
  cors:
    origins: ["http://localhost:5173"]

store:
  driver: sqlite          # Use sqlite for local dev
  dsn: ./data/app.db

cache:
  driver: memory          # In-memory cache for local dev
  # driver: servcache     # Switch to ServCache in production
  # endpoint: http://localhost:8082

auth:
  driver: jwt
  secret: ${JWT_SECRET}
  # driver: servauth      # Delegate to ServAuth in production
  # endpoint: http://localhost:8086
```

> **Tip:** Serv-lang uses **driver abstraction** — switch from in-memory to ServCache with two config lines and zero code changes.

---

## Step 4: Build and Run

```bash
serv run
```

Output:
```
✓  Compiling my-api...
✓  Generated 847 lines of Go
✓  Built in 1.2s
✓  UserService listening on :3000

Routes:
  GET     /api/v1/users
  GET     /api/v1/users/:id
  POST    /api/v1/users
  DELETE  /api/v1/users/:id
```

---

## Step 5: Test Your API

```bash
# Create a user
curl -X POST http://localhost:3000/api/v1/users \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"name": "Alice", "email": "alice@example.com"}'

# Get all users (cached for 30s)
curl http://localhost:3000/api/v1/users \
  -H "Authorization: Bearer $TOKEN"
```

---

## Step 6: Build for Production

```bash
# Compile to Go binary
serv build

# Or build a Docker image
serv docker build --tag my-api:latest
```

Switch your `serv.yaml` to production drivers:

```yaml
cache:
  driver: servcache
  endpoint: http://servcache:8082

auth:
  driver: servauth
  endpoint: http://servauth:8086
```

Start the ecosystem services:

```bash
docker run -d -p 8082:8082 ghcr.io/vyuvaraj/servcache:latest
docker run -d -p 8086:8086 ghcr.io/vyuvaraj/servauth:latest
docker run -d -p 3000:3000 my-api:latest
```

---

## What You Built

In 10 minutes, you went from zero to:

- ✅ A fully validated REST API with 4 endpoints
- ✅ JWT authentication on every route
- ✅ Cache layer (memory → ServCache in prod)
- ✅ SQLite persistence (swap to Postgres/MySQL in prod)
- ✅ A Dockerized production binary

---

## What's Next?

In the next post, we go deeper into **ServGate** — the API gateway that sits in front of all your services, handling routing, rate limiting, and auth forwarding.

➡️ [Building a Production API Gateway with ServGate](blog.html?post=03-api-gateway-servgate)

---

*Questions? Open a discussion in [Serv-lang](https://github.com/vyuvaraj/Serv-lang/discussions).*
