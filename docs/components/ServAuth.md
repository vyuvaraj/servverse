# ServAuth — Identity & Access Provider

> **Status:** 🟡 Stable | **Port:** 8098 | **Repository:** [ServAuth](https://github.com/vyuvaraj/ServAuth)

## Overview

Identity provider with OAuth2/OIDC token issuance, multi-tenant directories, MFA (TOTP/WebAuthn), social login federation, and RBAC policy enforcement.

## Key Features

- User registration and login (email/password)
- OAuth2/OIDC provider (authorization code, client credentials)
- Password reset with secure token recovery
- Account lockout (5 failed attempts → 5 min suspension)
- Multi-tenant isolated user directories
- Social login (Google, GitHub)
- MFA support (TOTP, WebAuthn)
- Session management with revocation
- Scoped API key issuance
- RBAC role/permission enforcement
- Envelope encryption (AES-GCM via KMS)
- Tenant JWT claim enforcement
- Structured JSON logging + OTel tracing
- Graceful shutdown on SIGTERM
- ServStore-backed persistence

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Listen port | `8098` |
| `SERV_JWT_SECRET` | JWT signing secret | (required) |
| `SERVSTORE_URL` | ServStore endpoint for persistence | (optional) |
| `SERV_OTLP_ENDPOINT` | OTel collector | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `POST /api/register` | User registration |
| `POST /api/login` | User login (returns JWT) |
| `POST /api/refresh` | Refresh token |
| `POST /api/reset-request` | Password reset request |
| `POST /api/mfa/verify` | MFA TOTP verification |
| `GET /oauth/authorize` | OAuth2 authorization |
| `POST /oauth/token` | OAuth2 token endpoint |
| `GET /.well-known/jwks.json` | JWKS public key |

## Serv-lang Integration

```srv
auth "my-jwt-secret"

route "POST" "/register" (req) {
    return auth.register(req.body.username, req.body.password, req.body.email)
}

route "GET" "/profile" (req) {
    let user = auth.currentUser(req)
    return { "user": user }
}
```
