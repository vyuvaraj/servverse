# Serv-Lang Language Guide

> **Serv-lang** is a high-level, domain-specific language for building production-grade microservices. It compiles to native Go binaries with zero configuration.

---

## Table of Contents

1. [Project Setup](#1-project-setup)
2. [Unified Application Block](#unified-application-block)
3. [Server & Routes](#2-server--routes)
4. [Request Binding](#3-request-binding)
5. [HTML & Web Responses](#4-html--web-responses)
6. [Database](#5-database)
7. [Variables & Data Types](#6-variables--data-types)
8. [Functions](#7-functions)
9. [Control Flow](#8-control-flow)
10. [Imports & Modules](#9-imports--modules)
11. [Authentication](#10-authentication)
12. [Pub/Sub Messaging](#11-pubsub-messaging)
13. [Scheduling & Cron](#12-scheduling--cron)
14. [Object Store (S3)](#13-object-store-s3)
15. [WebSockets](#14-websockets)
16. [Middleware](#15-middleware)
17. [Environment & Config](#16-environment--config)
18. [Error Handling](#17-error-handling)
19. [Concurrency](#18-concurrency)
20. [Observability (OTel)](#19-observability-otel)
21. [CLI Reference](#20-cli-reference)

---

## 1. Project Setup

### Single-file project
```python
# main.srv
server "9000"

export route "GET" "/" (req) {
    return { "message": "Hello, world!" }
}
```

## Unified Application Block

You can wrap configuration nodes and routes inside an `app` block to create a clean logical boundary:

```python
app GatewayService {
    server "9000"
    database "sqlite://app.db"

    export route "GET" "/health" (req) {
        return { "status": "UP" }
    }
}
```

### Multi-file project (serv.toml)
```toml
# serv.toml
entry = "main.srv"
name  = "my-service"
```

### Build & run
```bash
serv build main.srv          # compile to native binary
serv run main.srv            # compile + run
serv run main.srv --watch    # hot-reload on file changes
serv run main.srv --port 8080
```

---

## 2. Server & Routes

### Declare server port
```python
server "9000"
```

### Route declaration
```python
export route "METHOD" "/path" (req) {
    return { "key": "value" }
}
```

**Supported methods:** `GET`, `POST`, `PUT`, `PATCH`, `DELETE`, `HEAD`, `OPTIONS`

### Path parameters
```python
export route "GET" "/users/:id" (req) {
    let id = req.params["id"]
    return { "id": id }
}
```

### Query parameters
```python
export route "GET" "/search" (req) {
    let q = req.query["q"]
    return { "query": q }
}
```

### Rate limiting
```python
export route "POST" "/api/login" (req) @rate(5, "m") {
    # max 5 requests per minute per route
}
```

### CORS
```python
cors ["https://app.example.com", "https://admin.example.com"]
```

### Global IP rate limiting
```python
rate_limit 100 "m"   # 100 req/min per IP globally
```

---

## 3. Request Binding

### JSON body parsing
```python
export route "POST" "/api/users" (req) {
    let data = req.json()      # parse req.body as JSON
    let name  = data.name
    let email = data.email
}
```

### Form body parsing (application/x-www-form-urlencoded)
```python
export route "POST" "/contact" (req) {
    let form    = req.form()
    let message = form.message
}
```

### Safe param lookup (returns nil if missing)
```python
export route "GET" "/items/:id" (req) {
    let id = req.param("id")
    if id == nil {
        return { "error": "id required", "status": 400 }
    }
}
```

### Object destructuring
```python
let data = req.json()
let { name, email, age } = data
```

### Object shorthand (DX.S14)
```python
let name  = "Alice"
let email = "alice@example.com"
return { name, email }   # same as { name: name, email: email }
```

---

## 4. HTML & Web Responses

### Inline template
```python
export route "GET" "/" (req) {
    let tpl = `<!DOCTYPE html>
<html>
<head><title>{{.title}}</title></head>
<body><h1>Hello, {{.name}}!</h1></body>
</html>`
    return html.template(tpl, { "title": "Home", "name": "World" })
}
```

### File template
```python
export route "GET" "/" (req) {
    return html.render("views/index.html", { "user": user })
}
```

### Static file server
```python
html.static("/assets", "./public")    # serves ./public at /assets/
```

### Redirect
```python
export route "GET" "/old" (req) {
    return html.redirect("/new", 301)    # permanent
}

export route "GET" "/login-required" (req) {
    return html.redirect("/login", 302)  # temporary
}
```

### Implicit Content-Type inference (DX.S15)
When a route returns a plain string, Content-Type is automatically set:

| Return string starts with | Content-Type set |
|---|---|
| `<html`, `<!DOCTYPE` | `text/html; charset=utf-8` |
| `<?xml`, `<rss`, `<feed` | `application/xml; charset=utf-8` |
| `{...}` or `[...]` | `application/json` |
| anything else | `text/plain; charset=utf-8` |

---

## 5. Database

### Declare database
```python
database "sqlite://./app.db"
database "postgres://user:pass@localhost/mydb"
```

### Query
```python
let users = db.query("SELECT * FROM users WHERE active = ?", [true])
```

### Execute (insert/update/delete)
```python
db.exec("INSERT INTO users (name, email) VALUES (?, ?)", [name, email])
```

### Schema migrations
```python
migration "create_users_table" {
    db.exec(`CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )`)
}
```

---

## 6. Variables & Data Types

```python
let name  = "Alice"          # string
let age   = 30               # integer
let score = 9.5              # float
let active = true            # boolean
let items = [1, 2, 3]        # array
let user  = { "name": "Alice", "age": 30 }  # map/object

# Shorthand
let user  = { name, age }    # { name: name, age: age }

# Destructuring
let { name, age } = user

# String interpolation
let msg = f"Hello, {name}! You are {age} years old."

# Multi-line string
let html = `
<h1>Hello</h1>
<p>World</p>
`
```

---

## 7. Functions

```python
fn greet(name) {
    return f"Hello, {name}!"
}

export fn add(a, b) {      # exported = usable across files
    return a + b
}

let double = fn(x) { return x * 2 }  # anonymous function

# Higher-order functions
fn apply(val, fn) { return fn(val) }
let result = apply(10, fn(x) { return x * x })
```

---

## 8. Control Flow

### If / else
```python
if age >= 18 {
    return { "access": true }
} else {
    return { "access": false }
}
```

### For loop
```python
for i = 0; i < 10; i++ {
    log(i)
}
```

### For-in
```python
for item in items {
    log(item)
}
```

### Match
```python
match status {
    "active"   -> { return { "ok": true } }
    "inactive" -> { return { "ok": false } }
    _          -> { return { "error": "unknown" } }
}
```

---

## 9. Imports & Modules

```python
import "./handlers/users"          # imports users.srv
import "./utils/validation.srv"
import { validateEmail } from "./auth/utils"  # named import

# Wildcard directory import (DX.S16)
import "./handlers/*"              # imports all .srv in ./handlers/

# Stdlib
import "stdlib/auth"
import "stdlib/pagination"
```

---

## 10. Authentication

```python
auth "my-jwt-secret"               # enable JWT auth

# Register & login routes
export route "POST" "/auth/register" (req) {
    let data = req.json()
    return auth.register(data.username, data.password, data.email)
}

export route "POST" "/auth/login" (req) {
    let data = req.json()
    return auth.login(data.username, data.password)
}

# Protected route (JWT middleware auto-applied)
export route "GET" "/api/profile" (req) {
    let user = auth.currentUser(req)
    return { "user": user }
}

# Role-based access control
export route "DELETE" "/admin/users/:id" (req) @middleware("auth.role(\"admin\")") {
    # admin only
}
```

---

## 11. Pub/Sub Messaging

```python
broker "servqueue://localhost:4222"
# or in-memory: broker "memory://"

publish "user.created" { "id": userId, "email": email }

subscribe "user.created" (event) {
    log(f"New user: {event.email}")
}
```

---

## 12. Scheduling & Cron

```python
every "5m" {
    # runs every 5 minutes
    let result = db.query("SELECT COUNT(*) as cnt FROM users")
    log(f"Total users: {result[0].cnt}")
}

cron "0 9 * * MON-FRI" {
    # 9:00 AM weekdays
    publish "reports.daily" { "type": "morning" }
}
```

---

## 13. Object Store (S3)

```python
store "s3://access:secret@localhost:9000/my-bucket"
# or: store "file://./data"

store.put("profile/alice.json", { "name": "Alice" })
let profile = store.get("profile/alice.json")
```

---

## 14. WebSockets

```python
ws "/chat" (conn) {
    conn.send({ "msg": "Welcome!" })
    let msg = conn.receive()
    while msg != nil {
        conn.broadcast(msg)
        msg = conn.receive()
    }
}
```

---

## 15. Middleware

```python
middleware authMiddleware(req) {
    let token = req.headers["authorization"]
    if token == nil {
        return { "error": "Unauthorized", "status": 401 }
    }
    # return nil = pass through to handler
}

export route "GET" "/api/data" (req) @middleware("authMiddleware") {
    return { "data": "secret" }
}
```

---

## 16. Environment & Config

```python
let port   = env("PORT")
let secret = env.secret("JWT_SECRET")  # masked in logs
```

---

## 17. Error Handling

```python
try {
    let data = db.query("SELECT * FROM users")
    return data
} catch (err) {
    return { "error": err, "status": 500 }
}

# Error propagation (? operator)
fn fetchUser(id) {
    let user = db.query("SELECT * FROM users WHERE id = ?", [id])?
    return user
}
```

---

## 18. Concurrency

```python
# Async (blocks until done)
let result = await fn() {
    return db.query("SELECT * FROM expensive_table")
}

# Parallel fan-out
let [users, orders] = await_all([
    fn() { return db.query("SELECT * FROM users") },
    fn() { return db.query("SELECT * FROM orders") }
])

# Fire-and-forget (inherits trace context)
spawn fn() {
    publish "notifications.send" { "to": email }
}
```

---

## 19. Observability (OTel)

```python
otel "my-service-name"    # enable OpenTelemetry
```

Serv-lang automatically traces:
- Every HTTP request (with `traceparent` propagation)
- DB queries, cache ops, HTTP client calls, pub/sub, scheduler jobs

Built-in endpoints:
- `GET /metrics` — Prometheus metrics
- `GET /health` — liveness probe
- `GET /ready` — readiness probe

---

## 20. CLI Reference

| Command | Description |
|---|---|
| `serv build <file>` | Compile to native binary |
| `serv run <file>` | Compile and run |
| `serv run <file> --watch` | Run with hot-reload |
| `serv run <file> --port 8080` | Override port |
| `serv test <file>` | Run .srv tests |
| `serv test --watch` | Rerun tests on change |
| `serv fmt <file>` | Format source file |
| `serv lint <file>` | Lint source file |
| `serv doc <file>` | Generate API docs |
| `serv doctor` | Ecosystem health check |
| `serv new <name>` | Scaffold new project |
| `serv build --target wasm` | Compile to WebAssembly |
| `serv build --target linux` | Cross-compile to Linux |
| `serv deploy` | Deploy to ServCloud |

---

*This guide covers serv-lang v0.1.x. For changelog, see [RELEASE_NOTES.md](./RELEASE_NOTES.md).*
