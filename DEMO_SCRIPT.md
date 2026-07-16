# Servverse 10-Minute Demo Video — Script & Storyboard

> **AG.4** | Record: install → write service → deploy → observe in console  
> Host on YouTube + embed in GitHub Pages / servverse-repo landing page  
> Total runtime: ~10 minutes

---

## Pre-recording Checklist

- [ ] Clean machine (or fresh VM / Docker Desktop) with no prior Serv installation
- [ ] Terminal: Warp or iTerm2 (large font, dark theme)
- [ ] VS Code open with the Serv LSP extension installed
- [ ] ServConsole pre-seeded with a few traces from the showcase app
- [ ] OBS or Loom ready; resolution 1920x1080; 60fps

---

## Scene 1 — One-Line Install (0:00 – 1:00)

**Narration:**
> "Getting started with Servverse takes exactly one command. Let's install the entire ecosystem on a fresh machine."

**Screen:** Full-screen terminal

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/vyuvaraj/servverse-repo/main/scripts/install.sh | bash

# Windows (PowerShell)
irm https://raw.githubusercontent.com/vyuvaraj/servverse-repo/main/scripts/install.ps1 | iex
```

**Show:** Binary list printed after install — `servgate`, `servstore`, `servqueue`, `servconsole`, `serv` compiler, etc.

> "One command, 16 services, cross-platform. No Docker required, no JVM, no Node. Pure Go binaries."

---

## Scene 2 — Write a Service in Serv-lang (1:00 – 3:30)

**Narration:**
> "Now let's build a real REST API. We'll use Serv-lang — a compiled language where infrastructure is syntax, not an import."

**Screen:** VS Code, create `api.srv`

```
service OrderAPI {

  store "orders" {
    backend: "servstore://localhost:9000"
  }

  cache "order-cache" {
    ttl: 60s
  }

  broker "events" {
    backend: "servqueue://localhost:8082"
  }

  route POST /orders -> Order {
    let order = json.decode<Order>(request.body)
    store.put("orders", order.id, order)
    broker.publish("events", "order.created", order)
    response.json(order)
  }

  route GET /orders/{id} -> Order {
    cached fn getOrder(id string) Order {
      return store.get("orders", id)
    }
    response.json(getOrder(params.id))
  }

}
```

**Show:** VS Code LSP in action — hover docs on `store`, `broker`, auto-complete, inline type errors.

> "Notice: `store`, `broker`, `cache` are keywords. Not imports. The compiler validates that these services exist at build time."

```bash
serv build api.srv
```

**Show:** Fast compile output, zero errors.

---

## Scene 3 — Run Locally (3:30 – 4:30)

**Screen:** Split terminal — start ecosystem, then the service

```bash
# Start the infrastructure (ServStore, ServQueue, ServConsole)
docker-compose up -d

# Run the compiled service
./api
```

**Show:** Curl commands

```bash
curl -X POST http://localhost:8080/orders \
  -H "Content-Type: application/json" \
  -d '{"id":"ord_001","item":"keyboard","qty":1}'

curl http://localhost:8080/orders/ord_001
```

> "Order created, stored in ServStore, event published to ServQueue — all from 15 lines of code."

---

## Scene 4 — Deploy to ServCloud (4:30 – 5:30)

**Narration:**
> "Now let's deploy. ServCloud is our orchestrator — think systemd meets Kubernetes, but a single binary."

```bash
serv deploy api.srv --cloud localhost:7070 --name order-api

servcloud status
```

**Show:** Table listing `order-api -> RUNNING | 1 replica | p99: 2ms`

> "Blue-green deployments, autoscale rules, branch previews — all built in."

---

## Scene 5 — Observe in ServConsole (5:30 – 8:00)

**Screen:** Browser -> http://localhost:9090

**Show in sequence:**

1. **Topology view** — live graph of services with health indicators
2. **Click `order-api`** — request waterfall, OTel traces from the 3 curl calls
3. **Expand a trace** — shows `route POST /orders` -> `store.put` -> `broker.publish` spans
4. **Metrics panel** — RPS, p99 latency, error rate
5. **ServQueue panel** — `order.created` topic, message count, consumer lag = 0

> "ServConsole is not just dashboards — it's a control plane. Every service auto-reports telemetry with zero configuration."

---

## Scene 6 — Ecosystem Overview Montage (8:00 – 9:30)

**Narration (voiceover):**
> "In the last 8 minutes you saw Serv-lang compile, ServStore persist, ServQueue route events, and ServConsole observe everything. But the ecosystem goes deeper."

**Quick cuts (5-8 seconds each):**

| Cut | Shows |
|-----|-------|
| ServGate config | AI prompt guard, WASM middleware, LLM routing |
| ServAuth login flow | JWT, MFA, OIDC, magic links |
| ServFlow DAG | Workflow definition and Mermaid visualization |
| ServTrace waterfall | Cross-service trace with .srv source line mapping |
| VS Code extension | Sidebar health panel, CodeLens test runner |

---

## Scene 7 — Call to Action (9:30 – 10:00)

**Screen:** GitHub repo page

**Narration:**
> "Servverse is fully open source under Apache 2.0. Star the repo, try the showcase app, or join our Discord. Links in the description."

**Lower-third text:**
- github.com/vyuvaraj/servverse-repo
- star | docs | discord

---

## Production Notes

| Item | Detail |
|------|--------|
| **Music** | Royalty-free lo-fi (Pixabay or Uppbeat), -18 LUFS |
| **Captions** | Auto-generated via YouTube, reviewed for technical terms |
| **Chapters** | Add YouTube timestamps matching each scene above |
| **Thumbnail** | Dark background, "10 min" badge, Servverse logo, terminal window |
| **Description** | Include install commands, repo link, showcase app link, Discord |
| **Embed** | Add iframe to servverse-repo/index.html hero section |
