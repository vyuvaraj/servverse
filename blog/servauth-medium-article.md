# Secure Identity & Access Management with ServAuth

In the modern microservices ecosystem, identity, authentication, and token management are core pillars of application security. Designing a robust Identity Provider (IdP) that supports JSON Web Key Sets (JWKS), Role-Based Access Control (RBAC), Multi-Factor Authentication (MFA), and pluggable Social OAuth providers is often a multi-week engineering project. 

Enter **ServAuth**: the built-in identity server of the Servverse ecosystem designed to deliver enterprise-grade access control out-of-the-box.

---

## The Identity Architecture of ServAuth

ServAuth is a standalone IDP server running natively on port `8098`. It exposes a series of standardized OAuth2 and custom endpoints designed for low latency and cryptographically secure credentials verification:

- **/api/auth/register**: Secure account signup using bcrypt password hashing.
- **/api/auth/login**: User authentication returning cryptographically signed JWT tokens.
- **/api/auth/jwks** & **/.well-known/jwks.json**: Exposes the public key sets (JWKS) to verify JWT signatures in downstream services without hitting the database.
- **/api/auth/mfa/setup** & **verify**: Supports TOTP (Google Authenticator, Duo) for secure multi-factor challenges.
- **/api/auth/social/login** & **callback**: Pluggable redirect flows supporting Google, GitHub, and GitLab authentications.

---

## Pluggable Multi-Factor Authentication (MFA)

ServAuth separates its TOTP engine behind clean boundary interfaces to keep the base open-source server clean while allowing custom integrations:

```go
type TOTPEngine interface {
    GenerateSecret(username string) (secret string, qrCodeURL string, err error)
    VerifyToken(secret string, token string) bool
}
```

When a user requests MFA setup, ServAuth generates a base32 TOTP secret, formats a standard `otpauth://` URI, and returns a QR code payload. Verification executes time-sliced sliding window evaluations to account for minor clock drifts on user devices.

---

## Token Verification via JWKS

One of the major performance bottlenecks in distributed authorization is hitting a central database on every HTTP request to check if a token is valid. ServAuth avoids this via a JSON Web Key Set (JWKS) architecture:

1. **Key Generation**: At startup, ServAuth generates or loads a secure RSA keypair.
2. **Public Key Exposure**: Downstream services (like the `ServGate` API Gateway) fetch the public keys via `/.well-known/jwks.json` and cache them in-memory.
3. **Decentralized Verification**: When a client sends a JWT, `ServGate` verifies the signature using the cached public keys. Zero database roundtrips required!

---

## Pluggable Credential Stuffing Detection

Credential stuffing—where attackers use bots to automate thousands of login attempts using leaked passwords—is a critical threat. ServAuth features a pluggable detection hook that monitors login failures:

- **OSS Lockout**: Base lockout policies temporarily freeze accounts that exceed 5 login failures.
- **Enterprise Detector**: Leverages sliding-window IP analysis to flag distributed botnets attempting multi-account stuffing attacks, immediately redirecting those requests to high-security captcha steps or blocking them at the firewall gateway.

---

## Getting Started

Integrating ServAuth into your `Serv-lang` services is direct. Define your auth requirements using the gateway middleware, and `ServGate` handles token extraction and signature checking automatically, leaving you to focus solely on writing business logic!
