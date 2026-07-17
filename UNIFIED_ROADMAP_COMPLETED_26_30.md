# Serv Unified Ecosystem Roadmap - Completed Items (Phases 26-30)

This document preserves the archived history of completed items for Phase 26 and subsequent phases.

---

## Phase 26: Competitive Differentiation (Completed Moats)

- **CD.1: Infrastructure-as-syntax � `broker`, `store`, `cache`, `ai` are keywords, not library imports. Compile error if misconfigured** — No other language makes infrastructure a first-class citizen. [July 17, 2026]
- **CD.2: AI code generation feedback loop � `serv create "prompt"` generates code, `serv test` validates it, `serv create --fix` repairs failures automatically** — No compiler has built-in AI repair cycle. [July 17, 2026]
- **CD.3: Compile-time service contract validation � If route declares `-> User`, compiler verifies the response shape matches the struct at build time** — TypeScript has this at type level but not for HTTP responses. [July 17, 2026]
- **CD.4: WASM middleware hot-swap during live traffic � Zero-downtime middleware deploys at request boundary, not pod restart** — Envoy needs full pod restart for filter changes. [July 17, 2026]
- **CD.5: MCP (AI agent) native traffic type � Understands JSON-RPC tool calls, per-agent rate limiting, token cost tracking** — No gateway understands AI agent protocols natively. [July 17, 2026]
- **CD.6: Policy-as-code ? WASM compilation � Write human-readable `.policy` files, compile to native-speed WASM** — OPA/Rego is interpreted. ServGate compiles policies. [July 17, 2026]
- **CD.7: Compute-near-data (WASM transforms on stored objects) � Resize images, convert formats, validate data server-side with zero cold start** — No other storage engine executes user code on objects in-process. [July 17, 2026]
- **CD.8: Semantic search built into storage � Upload a document ? auto-embedded ? queryable by meaning in the same API call** — AWS S3 Vectors is separate. ServStore unifies store+search. [July 17, 2026]
- **CD.9: Time-travel queries with temporal API � `GET /bucket/key?at=2026-07-01T14:00:00Z` returns exact state at that moment** — S3 versioning requires listing all versions manually. [July 17, 2026]
- **CD.10: Inline WASM transforms in the message path � Filter, enrich, route messages inside the broker without external processors** — No broker runs arbitrary user code in the message pipeline. [July 17, 2026]
- **CD.11: Single binary: STOMP + HTTP + WASM + WAL + Raft � One file, zero dependencies. Kafka = JVM + ZooKeeper. RabbitMQ = Erlang** — Unmatched operational simplicity. [July 17, 2026]
- **CD.12: Language-native protocol � `broker "servqueue://host"` in Serv compiles to zero-config STOMP client with auto-auth and tracing** — Every other broker needs SDK import + manual configuration. [July 17, 2026]
- **CD.13: Ecosystem-native zero-config observability � All Serv services auto-report metrics. No exporters, no scrape configs, no dashboard imports** — Grafana needs Prometheus + exporters + dashboards configured per service. [July 17, 2026]
- **CD.14: Bidirectional control plane � Not just observe: create buckets, deploy services, hot-swap middleware, execute runbooks FROM the dashboard** — Grafana/Datadog are read-only. ServConsole is an operations plane. [July 17, 2026]
- **CD.15: AI-powered incident correlation � Alert fires ? auto-correlates deploys, config changes, upstream failures ? generates hypothesis** — Datadog has this but at enterprise pricing. ServConsole is self-hosted. [July 17, 2026]
- **CD.16: Single binary, zero dependencies � No Elasticsearch, no Cassandra, no Kafka. One Go binary with in-memory + cold tier** — Jaeger needs Elasticsearch/Cassandra. Tempo needs S3 + memcached. [July 17, 2026]
- **CD.17: Compiler-linked source mapping � Trace spans map back to `.srv` source lines, not generated Go code** — No other tracing backend understands the source language. [July 17, 2026]
- **CD.18: Natural language trace query � "Show me slow requests to ServAuth in the last hour" ? structured query** — No open-source tracer has NL search. [July 17, 2026]
- **CD.19: Auto-namespace isolation per service � Services sharing one cache instance can't see each other's keys. Zero-config tenant safety** — Redis requires manual key prefixing discipline. [July 17, 2026]
- **CD.20: Language-native `cached fn` syntax � Declare cache behavior at the function level, compiler generates the get/set/invalidation code** — No cache system integrates at the language/compiler level. [July 17, 2026]
- **CD.21: Read-through/write-behind with ServPool � Automatic DB synchronization patterns without application code** — Redis requires custom lua scripts or app-level orchestration. [July 17, 2026]
- **CD.22: Library-level, no sidecars � Runs inside the binary via custom HTTP transport. Zero CPU/memory overhead of sidecar proxies** — Istio/Linkerd = Envoy sidecar per pod. ServMesh = embedded library. [July 17, 2026]
- **CD.23: `serv://` URL scheme in the language � Inter-service calls are syntax: `http.get("serv://user-service/users/123")`** — No other mesh integrates at the language level. [July 17, 2026]
- **CD.24: Sub-millisecond service resolution � In-process cache, no network hop to control plane for each request** — Istio routes through Envoy sidecar (added network hop per call). [July 17, 2026]
- **CD.25: Native language syntax for workflows � `workflow "name" { step "x" { ... } }` in .srv files. Compiler validates DAG at build time** — Temporal uses Go/Java SDKs. Step Functions uses JSON. ServFlow uses language syntax. [July 17, 2026]
- **CD.26: Time-travel workflow replay � Debug by stepping through execution history: see state at each checkpoint** — Temporal has event history but no interactive replay visualization. [July 17, 2026]
- **CD.27: Single binary with embedded state � No external database required. State persists to local files or ServStore** — Temporal = server + database + workers. ServFlow = one binary. [July 17, 2026]
- **CD.28: OTel trace propagation through the tunnel � Incoming webhook requests automatically get trace context injected** — No tunnel service preserves distributed tracing context. [July 17, 2026]
- **CD.29: Request inspection with REST API � Scriptable inspection: `GET /api/inspect` returns captured requests for CI/CD test automation** — ngrok's inspection is proprietary dashboard, not API-accessible. [July 17, 2026]
- **CD.30: Self-hosted relay (zero vendor lock-in) � Run your own relay server. No usage limits, no accounts, no billing** — ngrok/Cloudflare = SaaS with limits. ServTunnel = your infrastructure. [July 17, 2026]
- **CD.31: Single binary, embedded in your stack � No Java (Keycloak), no SaaS pricing (Auth0). One Go binary** — Keycloak = JVM + PostgreSQL. Auth0 = per-MAU pricing. [July 17, 2026]
- **CD.32: Language-native auth primitives � `auth.register()`, `auth.login()`, `auth.currentUser()` are builtins** — Every other auth system requires SDK import + initialization. [July 17, 2026]
- **CD.33: Ecosystem-integrated identity � JWT issued by ServAuth works across all Serv services automatically via ServShared** — Auth0 tokens need per-service validation configuration. [July 17, 2026]
- **CD.34: Language-native scheduling � `every 5m { ... }` and `cron "0 9 * * MON-FRI" { ... }` are syntax, not config files** — No scheduler integrates at the language level. [July 17, 2026]
- **CD.35: Distributed leader election built-in � Multi-replica deployments automatically elect one runner. No ZooKeeper/etcd** — K8s CronJobs can duplicate if misconfigured. ServCron guarantees once. [July 17, 2026]
- **CD.36: Multi-dialect proxy � One pooler supports PostgreSQL, SQLite, Oracle, MongoDB simultaneously** — PgBouncer = PostgreSQL only. ProxySQL = MySQL only. ServPool = all. [July 17, 2026]
- **CD.37: Integrated query analytics and slow query detection � No separate APM tool needed. Built-in query profiling with OTel spans** — PgBouncer has zero observability. ServPool exports everything. [July 17, 2026]
- **CD.38: Multi-channel in one service � SMTP email + Slack + SMS + webhooks from a single API endpoint** — SendGrid = email only. Need Twilio for SMS, Slack API separately. [July 17, 2026]
- **CD.39: Language-native `notify()` syntax � `notify("slack", msg)` is a builtin, not a library call** — Every notification service requires SDK setup per channel. [July 17, 2026]
- **CD.40: Language-native lock syntax � `lock("resource", 30s) { ... }` is a keyword, compiler ensures unlock on all exit paths** — Redis locks require manual lock/unlock discipline. ServLock is syntax. [July 17, 2026]
- **CD.41: Fencing token support � Auto-generated monotonic tokens prevent split-brain stale writes** — Redis Redlock has no fencing. ServLock enforces it at protocol level. [July 17, 2026]
- **CD.42: Cryptographic package signing with verification � Packages are signed on publish, verified on install. Supply chain security built-in** — npm has no mandatory signing. crates.io has no signing at all. [July 17, 2026]
- **CD.43: BFS dependency tree resolution with conflict detection � Resolve entire dependency graph server-side before download** — npm resolves client-side. ServRegistry resolves before any bytes transfer. [July 17, 2026]
- **CD.44: Compiler-aware documentation � Reads .srv source directly. No annotations, no comments, no OpenAPI spec writing. The code IS the documentation** — Every other doc tool requires manual spec writing or annotation. [July 17, 2026]
- **CD.45: Dual output (HTML + OpenAPI) from one parse � Single command generates both interactive docs AND machine-readable spec** — Swagger UI only renders existing specs. ServDocs generates them. [July 17, 2026]
- **CD.46: Dead code elimination across service boundaries ? Compiler traces which routes are actually called by other services (via ServMesh registry) and warns on unused endpoints** — No language eliminates dead code across microservice boundaries. [July 17, 2026]
- **CD.48: Type-safe inter-service contracts ? When Service A calls Service B via `serv://`, compiler verifies A's expected response type matches B's declared return type** — gRPC has this via proto. REST has nothing. Serv does it for REST. [July 17, 2026]
- **CD.49: Built-in migration diffing ? `serv migrate --dry-run` shows exact SQL that will execute (CREATE/ALTER/DROP) with colored diff against current schema** — Rails has this. No compiled language has built-in migration preview. [July 17, 2026]
- **CD.49: Built-in migration diffing ? `serv migrate --dry-run` shows exact SQL that will execute (CREATE/ALTER/DROP) with colored diff against current schema** — Rails has this. No compiled language has built-in migration preview. [July 17, 2026]
- **CD.50: Request/response WASM A/B testing � Run two WASM versions simultaneously with weighted traffic split, compare response quality metrics** — No gateway supports A/B testing of middleware logic. [July 17, 2026]
- **CD.51: Prompt injection firewall � Deep content inspection using embedding similarity to detect adversarial prompts before they reach LLM backends** — WAFs check SQL injection. ServGate checks prompt injection. [July 17, 2026]
- **CD.52: Auto-generated API changelog ? Track route additions/removals/changes over time. Serve changelog at `/api/changelog` for consumer teams** — No gateway auto-generates API evolution history. [July 17, 2026]
- **CD.53: Object-level access audit trail � Who read/wrote/deleted every object, when, from which IP. Immutable append-only log per bucket** — S3 server access logging is bucket-level, not object-level with identity. [July 17, 2026]
- **CD.54: WASM trigger on object events � Declare functions that auto-execute on PutObject/DeleteObject. Lambda@S3 but inside the engine with zero cold start** — AWS needs Lambda + event bridge. ServStore runs triggers in-process. [July 17, 2026]
- **CD.55: Content-type aware compression � Auto-compress text/JSON/logs with zstd on write, decompress transparently on read. Zero client changes** — No S3-compatible engine does transparent per-content-type compression. [July 17, 2026]
- **CD.56: Transform pipeline chaining � Chain multiple WASM transforms: `raw ? validate.wasm ? enrich.wasm ? route.wasm ? processed`. Declarative pipeline** — No broker supports composable multi-stage transform chains. [July 17, 2026]
- **CD.57: Message-level end-to-end tracing � Track a message from publish ? through every transform ? DLQ redirect ? consumer ack. Single distributed trace** — Most brokers lose trace context between producer and consumer. [July 17, 2026]
- **CD.58: Consumer-side backpressure with automatic DLQ overflow � When consumer is slow, buffer to disk ? if still slow, auto-route to DLQ with metadata** — Kafka drops, RabbitMQ requeues infinitely. ServQueue has intelligent overflow. [July 17, 2026]
- **CD.59: Cross-service request replay � Select a trace in waterfall ? click "Replay" ? re-issues the exact request through ServGate. Instant reproduction** — No dashboard can replay production requests through the actual gateway. [July 17, 2026]
- **CD.60: Embedded SQL workbench � Run queries against any connected database directly from the console. No separate DB client needed** — Grafana can visualize queries. ServConsole can WRITE them. [July 17, 2026]
- **CD.61: One-click infrastructure provisioning � Create ServStore buckets, ServQueue topics, ServCache namespaces from the UI. The dashboard IS the control plane** — Portainer manages containers. ServConsole manages application infrastructure. [July 17, 2026]
- **CD.62: Automatic mTLS without certificate management � ServMesh auto-provisions and rotates certificates. Zero PKI infrastructure. Zero config** — Istio needs cert-manager or Vault integration. ServMesh is self-contained. [July 17, 2026]
- **CD.63: Circuit breaker state visible in ServConsole � See which circuits are open/closed/half-open in real-time dashboard. Click to force-reset** — Istio circuit state is invisible without custom metrics + Grafana. [July 17, 2026]
- **CD.64: Saga compensation with automatic rollback ordering � Fail at step N ? compensations fire in reverse (N?N-1?...?1) automatically** — Temporal requires manual compensation ordering. ServFlow derives it from DAG. [July 17, 2026]
- **CD.65: Human approval gates with timeout escalation � Workflow pauses for human approval. If no response in X time, auto-escalates or auto-approves** — Step Functions has approval but no escalation. ServFlow has both. [July 17, 2026]
- **CD.66: Workflow visualization as Mermaid DAG � `GET /api/workflows/visualize` returns a Mermaid diagram of the workflow graph** — No competitor generates visual DAG from workflow definition via API. [July 17, 2026]
- **CD.67: Progressive auth complexity � Start with password-only (5 min setup), add MFA later, add OAuth later, add SCIM later. No upfront complexity** — Keycloak forces full OIDC complexity on day 1. ServAuth grows with you. [July 17, 2026]
- **CD.68: Account lockout with automatic unlock � 5 attempts ? locked 5 min ? auto-unlocks. No admin intervention needed** — Auth0 requires manual unlock or custom rules. ServAuth is automatic. [July 17, 2026]
- **CD.46: Dead code elimination across service boundaries  Compiler traces which routes are actually called by other services (via ServMesh registry) and warns on unused endpoints** — No language eliminates dead code across microservice boundaries. [July 17, 2026]
- **CD.47: Compile-time dependency health check  `serv build` checks that all declared infrastructure (broker, store, cache) is reachable during compilation. Fail fast, not at runtime** — No compiler validates infrastructure availability at build time. [July 17, 2026]
- **CD.48: Type-safe inter-service contracts  When Service A calls Service B via `serv://`, compiler verifies A's expected response type matches B's declared return type** — gRPC has this via proto. REST has nothing. Serv does it for REST. [July 17, 2026]
- **CD.49: Built-in migration diffing  `serv migrate --dry-run` shows exact SQL that will execute (CREATE/ALTER/DROP) with colored diff against current schema** — Rails has this. No compiled language has built-in migration preview. [July 17, 2026]
- **CD.50: Request/response WASM A/B testing  Run two WASM versions simultaneously with weighted traffic split, compare response quality metrics** — No gateway supports A/B testing of middleware logic. [July 17, 2026]
- **CD.51: Prompt injection firewall  Deep content inspection using embedding similarity to detect adversarial prompts before they reach LLM backends** — WAFs check SQL injection. ServGate checks prompt injection. [July 17, 2026]
- **CD.52: Auto-generated API changelog  Track route additions/removals/changes over time. Serve changelog at `/api/changelog` for consumer teams** — No gateway auto-generates API evolution history. [July 17, 2026]
- **CD.53: Object-level access audit trail  Who read/wrote/deleted every object, when, from which IP. Immutable append-only log per bucket** — S3 server access logging is bucket-level, not object-level with identity. [July 17, 2026]
- **CD.54: WASM trigger on object events  Declare functions that auto-execute on PutObject/DeleteObject. Lambda@S3 but inside the engine with zero cold start** — AWS needs Lambda + event bridge. ServStore runs triggers in-process. [July 17, 2026]
- **CD.55: Content-type aware compression  Auto-compress text/JSON/logs with zstd on write, decompress transparently on read. Zero client changes** — No S3-compatible engine does transparent per-content-type compression. [July 17, 2026]
- **CD.56: Transform pipeline chaining  Chain multiple WASM transforms: `raw ? validate.wasm ? enrich.wasm ? route.wasm ? processed`. Declarative pipeline** — No broker supports composable multi-stage transform chains. [July 17, 2026]
- **CD.57: Message-level end-to-end tracing  Track a message from publish ? through every transform ? DLQ redirect ? consumer ack. Single distributed trace** — Most brokers lose trace context between producer and consumer. [July 17, 2026]
- **CD.58: Consumer-side backpressure with automatic DLQ overflow  When consumer is slow, buffer to disk ? if still slow, auto-route to DLQ with metadata** — Kafka drops, RabbitMQ requeues infinitely. ServQueue has intelligent overflow. [July 17, 2026]
- **CD.59: Cross-service request replay  Select a trace in waterfall ? click "Replay" ? re-issues the exact request through ServGate. Instant reproduction** — No dashboard can replay production requests through the actual gateway. [July 17, 2026]
- **CD.60: Embedded SQL workbench  Run queries against any connected database directly from the console. No separate DB client needed** — Grafana can visualize queries. ServConsole can WRITE them. [July 17, 2026]
- **CD.61: One-click infrastructure provisioning  Create ServStore buckets, ServQueue topics, ServCache namespaces from the UI. The dashboard IS the control plane** — Portainer manages containers. ServConsole manages application infrastructure. [July 17, 2026]
- **CD.62: Automatic mTLS without certificate management  ServMesh auto-provisions and rotates certificates. Zero PKI infrastructure. Zero config** — Istio needs cert-manager or Vault integration. ServMesh is self-contained. [July 17, 2026]
- **CD.63: Circuit breaker state visible in ServConsole  See which circuits are open/closed/half-open in real-time dashboard. Click to force-reset** — Istio circuit state is invisible without custom metrics + Grafana. [July 17, 2026]
- **CD.64: Saga compensation with automatic rollback ordering  Fail at step N ? compensations fire in reverse (N?N-1?...?1) automatically** — Temporal requires manual compensation ordering. ServFlow derives it from DAG. [July 17, 2026]
- **CD.65: Human approval gates with timeout escalation  Workflow pauses for human approval. If no response in X time, auto-escalates or auto-approves** — Step Functions has approval but no escalation. ServFlow has both. [July 17, 2026]
- **CD.66: Workflow visualization as Mermaid DAG  `GET /api/workflows/visualize` returns a Mermaid diagram of the workflow graph** — No competitor generates visual DAG from workflow definition via API. [July 17, 2026]
- **CD.67: Progressive auth complexity  Start with password-only (5 min setup), add MFA later, add OAuth later, add SCIM later. No upfront complexity** — Keycloak forces full OIDC complexity on day 1. ServAuth grows with you. [July 17, 2026]
- **CD.68: Account lockout with automatic unlock  5 attempts ? locked 5 min ? auto-unlocks. No admin intervention needed** — Auth0 requires manual unlock or custom rules. ServAuth is automatic. [July 17, 2026]
- **CD.69: Compiler-guaranteed unlock  `lock("x") { ... }` syntax ensures the lock is released on ALL exit paths (return, panic, early exit). Impossible to forget** — Redis locks require explicit defer/finally. ServLock is structural. [July 17, 2026]
- **CD.70: Lock queueing with fairness  Multiple waiters get the lock in FIFO order. No starvation** — Redis SETNX has no queue. Whoever retries fastest wins (unfair). [July 17, 2026]
- **CD.72: Unified install script � One curl/irm command installs every component. Cross-platform (Windows, macOS, Linux)** — Competitors install one tool at a time. Servverse installs the entire ecosystem. [July 17, 2026]
- **CD.73: SERVVERSE_DISCOVERY protocol � Single JSON manifest tells all services where to find each other. Change one file, all services update** — No competitor has a unified service discovery manifest format. [July 17, 2026]
- **CD.75: Consistent error format ecosystem-wide ? Every service returns `{"error":"msg","code":"ERR_X","trace_id":"..."}`. One error handler for any Serv service** — No platform enforces error format consistency across all components. [July 17, 2026]
- **CD.75: Consistent error format ecosystem-wide � Every service returns `{"error":"msg","code":"ERR_X","trace_id":"..."}`. One error handler for any Serv service** — No platform enforces error format consistency across all components. [July 17, 2026]
- **CD.76: Type-safe inter-service contracts  When Service A calls `serv://B/users`, compiler verifies A's expected response type matches B's declared return type. Compile error on mismatch** (Serv-lang) — gRPC has this. REST doesn't. First REST language to do this wins. [July 17, 2026]
- **CD.78: Dead code detection across service boundaries  Compiler queries ServMesh registry: "which routes are never called by any registered service?" Warns on unused endpoints** (Serv-lang + ServMesh) — Static analysis tools work within one repo. This works across repos. [July 17, 2026]
- **CD.78: Dead code detection across service boundaries  Compiler queries ServMesh registry: "which routes are never called by any registered service?" Warns on unused endpoints** (Serv-lang + ServMesh) — Static analysis tools work within one repo. This works across repos. [July 17, 2026]
- **CD.79: `serv create --fix`  AI generates code, tests fail, compiler feeds errors back to AI, AI fixes. Automated repair loop until tests pass or max retries** (Serv-lang) — Cursor/Copilot suggest code. None auto-repair compile errors in a loop. [July 17, 2026]
- **CD.80: `cached fn` keyword  `cached fn getUser(id) ttl 5m { return db.query(...) }`  compiler generates cache get/set/invalidation. No manual cache code** (Serv-lang + ServCache) — No language has cache-as-syntax. This is Serv's unique position. [July 17, 2026]
- **CD.81: Migration dry-run with colored diff  `serv migrate --dry-run` shows exact SQL (CREATE/ALTER/DROP) with green/red diff against live schema. No execution** (Serv-lang) — Rails has `rake db:migrate:status`. No compiled language has built-in diff preview. [July 17, 2026]
- **CD.83: Auto-generated API changelog  Track route additions/removals/breaking changes over time. Serve at `/api/changelog`. Consumer teams subscribe to diffs** (ServGate) — Bump.sh does this as SaaS. No self-hosted gateway has it built-in. [July 17, 2026]
- **CD.84: Request cost estimation header  Return `X-Estimated-Cost: $0.003` on AI-proxied requests before execution. Client can abort expensive calls** (ServGate) — No gateway previews cost before forwarding. Essential for AI budget control. [July 17, 2026]
- **CD.85: Automatic circuit breaker from SLO breach  If a backend's p99 exceeds SLO threshold, circuit opens automatically. No manual configuration per route** (ServGate + ServTrace) — Envoy needs explicit circuit config. ServGate derives it from observed SLOs. [July 17, 2026]
- **CD.86: Conversational object query  `GET /bucket?ask=What documents discuss authentication?`  synthesizes an answer from stored documents (RAG in storage layer)** (ServStore) — AWS Q&A on S3 is separate service. ServStore has it built-in. First mover advantage. [July 17, 2026]
- **CD.87: Auto-summarize on upload  Every uploaded document gets a 2-sentence summary stored as metadata. Enables "browse by summary" without downloading** (ServStore) — No storage engine generates summaries. Google Drive does this for Workspace. ServStore does for S3. [July 17, 2026]
- **CD.88: Object similarity deduplication  On upload, check if semantically similar document exists (cosine > 0.95). Warn or reject near-duplicates** (ServStore) — Google Drive detects exact duplicates. ServStore detects SEMANTIC duplicates. [July 17, 2026]
- **CD.89: Stream processing DSL � `stream "orders"** — > filter(o => o.total > 100). [July 17, 2026]
- **CD.90: AI-powered message routing � `subscribe "tickets" where ai.classify(msg) == "urgent"` � broker evaluates embedding model per message for routing** (ServQueue) — No broker has ML-based routing. When this ships, it's a category-defining feature. [July 17, 2026]
- **CD.91: Visual message flow in ServConsole ? Track a single message from publish ? transform ? DLQ ? retry ? consumer ack as an interactive timeline** (ServQueue + ServConsole) — Kafka has no message-level visibility. This makes debugging trivial. [July 17, 2026]
- **CD.92: Compiler-linked source mapping in traces � Trace spans show `.srv` file + line number, not generated Go code. Click span ? opens source in IDE** (ServTrace + Serv-lang) — No APM maps traces to DSL source. Only possible because Serv controls compiler + tracer. [July 17, 2026]
- **CD.93: Predictive capacity alerts � "At current growth rate, ServStore disk will be full in 14 days" � based on trend analysis, not threshold** (ServTrace + ServConsole) — Datadog has forecasting. No self-hosted tool does. First OSS to ship this wins. [July 17, 2026]
- **CD.94: Auto-generated incident postmortem ? After an alert resolves, auto-generate a structured postmortem: timeline, root cause, impact, remediation taken** (ServConsole) — PagerDuty has postmortems. No observability dashboard auto-generates them from trace data. [July 17, 2026]
- **CD.95: AI decision steps � `step "classify" { ai.classify(input, ["approve", "review", "reject"]) }` � AI-powered branching without external service** (ServFlow + Serv-lang) — Temporal has no AI primitives. Step Functions needs Lambda. ServFlow has it inline. [July 17, 2026]
- **CD.96: Workflow generation from natural language � "Create a workflow: validate order ? charge payment ? ship ? send confirmation" ? generates DAG definition** (ServFlow + Serv-lang) — No workflow engine generates workflow from description. This is the AI-era killer feature. [July 17, 2026]
- **CD.97: Cron job smart scheduling � Analyze historical execution: duration, resource usage, conflicts. Auto-suggest non-overlapping windows** (ServCron) — Airflow has SLA. No scheduler auto-optimizes schedule based on observed patterns. [July 17, 2026]
- **CD.98: Passwordless magic link + passkey � One-click login via email magic link or WebAuthn passkey. No password stored** (ServAuth) — Auth0/Clerk have this. ServAuth needs it to compete in the modern auth space. [July 17, 2026]
- **CD.99: Adaptive risk scoring per login � Score: new device(+3) + unusual time(+2) + different country(+5) = high risk ? step-up to MFA automatically** (ServAuth) — Auth0 has "Attack Protection". Self-hosted auth systems don't. ServAuth should. [July 17, 2026]
- **CD.100: SCIM 2.0 provisioning � Enterprise user/group sync from Okta, Azure AD, Google Workspace. Auto-create/disable accounts** (ServAuth) — Required for enterprise sales. Keycloak has it. Single-binary auth systems don't. [July 17, 2026]
- **CD.101: Web Playground � Write Serv code in browser ? compile via WASM ? run ? see output. Zero install** (Serv-lang) — Go, Rust, Zig all have playgrounds. Serv needs one for adoption. [July 17, 2026]
- **CD.102: `serv bench <file.srv>` � Auto-generates load tests from route declarations, runs them, reports p99/throughput** (Serv-lang) — No compiler auto-generates performance tests from source code. [July 17, 2026]
- **CD.103: Branch-based preview deployments � Push a branch ? ServCloud auto-deploys to unique URL ? share with team for review** (ServCloud) — Vercel/Netlify pioneered this. Backend frameworks don't have it. ServCloud should. [July 17, 2026]
- **CD.104: `serv doctor --integration` ? Boots full ecosystem via docker-compose, runs cross-service smoke tests, reports health matrix** (servverse-repo) — No platform has a "test everything works together" command. [July 17, 2026]
- **CD.101: Web Playground  Write Serv code in browser ? compile via WASM ? run ? see output. Zero install** (Serv-lang) — Go, Rust, Zig all have playgrounds. Serv needs one for adoption. [July 17, 2026]
- **CD.102: `serv bench <file.srv>`  Auto-generates load tests from route declarations, runs them, reports p99/throughput** (Serv-lang) — No compiler auto-generates performance tests from source code. [July 17, 2026]
- **CD.103: Branch-based preview deployments  Push a branch ? ServCloud auto-deploys to unique URL ? share with team for review** (ServCloud) — Vercel/Netlify pioneered this. Backend frameworks don't have it. ServCloud should. [July 17, 2026]
- **CD.104: `serv doctor --integration`  Boots full ecosystem via docker-compose, runs cross-service smoke tests, reports health matrix** (servverse-repo) — No platform has a "test everything works together" command. [July 17, 2026]
- **CD.105: Cache stampede protection (singleflight)  Concurrent cache misses for same key coalesce into one computation. No thundering herd** (ServCache) — Redis doesn't prevent stampede. Application code must. ServCache does it at server level. [July 17, 2026]
- **CD.106: Lock queueing with fairness  Multiple waiters get lock in FIFO order. No starvation under high contention** (ServLock) — Redis SETNX has no queue (unfair retry). etcd leases have ordering. ServLock should too. [July 17, 2026]
- **CD.107: Lock observability in ServConsole  See active locks, wait queues, contention hotspots, deadlock detection in real-time dashboard** (ServLock + ServConsole) — No lock service has observability built-in. Debug distributed locks visually. [July 17, 2026]
- **CD.108: ServFlow visual DAG designer  Render live workflow graphs using Webviews and Mermaid inside the IDE** (ServFlow + VS Code) — Render live DAG flowcharts of steps and compensating tasks directly in the editor. [July 17, 2026]
- **CD.109: ServQueue Broker Explorer  Sidebar explorer to view topics, consumer groups, message traces, and deploy WASM transforms** (ServQueue + VS Code) — Browse message broker queues and deploy streaming transform triggers visually. [July 17, 2026]
- **CD.110: ServStore Bucket & Trigger manager  IDE explorer to manage object storage buckets, upload triggers, and browse metadata** (ServStore + VS Code) — Manage S3 bucket metadata, file trees, and WASM object trigger code. [July 17, 2026]
- **CD.111: ServLock Contention Dashboard  Debug distributed locks, deadlocks, and FIFO waiter queues live inside the editor** (ServLock + VS Code) — Real-time observability of waiter queue and contention hotspots directly in the workspace. [July 17, 2026]
- **CD.112: ServGate Route Simulator — Mock gateway configurations and simulate route/cost routing rules from the IDE** (ServGate + VS Code) — Simulate API request routing and prompt injection rules locally without sandbox deployment. [July 17, 2026]
- **CD.113: Inlay type hints — Show inferred return types and parameter types inline next to `fn` signatures without hover** (Serv-lang + VS Code) — Reduces cognitive load for large codebases. JetBrains and Rust Analyzer pioneered this. [July 17, 2026]
- **CD.114: Rename symbol refactor - Rename any function, struct, or variable across all `.srv` files in the workspace** (Serv-lang LSP) — Essential refactoring tool. No language without this feels production-grade. [July 17, 2026]
- **CD.115: Test gutter decorations — Show green/red pass/fail icons in the editor gutter per `test "..."` block after running** (Serv-lang + VS Code) — Go and Rust have this. Turns the editor into a live test dashboard. [July 17, 2026]
- **CD.116: Import auto-organization — Detect and auto-suggest stdlib imports when user types `db.`, `cache.`, `http.`** (Serv-lang LSP) — TypeScript and Go have this. Saves repeated lookup of import paths. [July 17, 2026]
- **CD.117: `serv.initProject` scaffolding — Scaffold a new Serv project from a template picker in the command palette** (Serv-lang) — First-run DX. Reduces barrier to getting started with Serv. [July 17, 2026]
- **CD.118: `serv.deploy` one-click deploy — Deploy the current service to ServCloud directly from the editor** (ServCloud + VS Code) — Removes context switching to terminal for cloud deployments. [July 17, 2026]
- **CD.119: Services sidebar panel — Dedicated activity bar icon showing all 16 services with live 🟢/🔴 health icons** (ServRegistry + VS Code) — Always-visible ecosystem health beyond the status bar. [July 17, 2026]
- **CD.120: ServTunnel session viewer (`serv.viewTunnels`) — Active tunnel sessions with bandwidth and client IPs** (ServTunnel + VS Code) — Complete the service dashboard coverage across all 16 microservices. [July 17, 2026]
- **CD.121: `serv.openPlayground` - Embedded WASM web playground inside a VS Code Webview** (Serv-lang) — Allows zero-install experimentation without leaving the editor. [July 17, 2026]
- **CD.122: Coverage line highlights — Shade uncovered lines in red after `serv test --coverage`** (Serv-lang + VS Code) — Standard in Go and Python IDEs. Makes coverage actionable in-editor. [July 17, 2026]

## Phase 27: v1.0 Release Readiness (Completed Items)

- **V1.1: Add `/api/v1/` prefix to all endpoints** (ServCache, ServMesh, ServCloud, ServTunnel, ServAuth, ServPool, ServMail, ServFlow, ServLock) — 9 services use bare `/api/` paths. Add versioned prefix for clean future evolution. [July 17, 2026]
- **V1.2: Standardized error format** (ServCache, ServMesh, ServCloud, ServTunnel, ServAuth, ServPool, ServMail, ServFlow, ServLock) — Use `ServShared.WriteJSONError` returning `{"error":"msg","code":"ERR_X","trace_id":"..."}` on all error paths. [July 17, 2026]
- **V1.3: Add rate limiting to unprotected services** (ServCache, ServCron, ServCloud, ServTrace, ServAuth, ServPool, ServFlow, ServLock) — Use `ServShared.MaxBytesMiddleware` + sliding window rate limiter. Prevents API abuse. [July 17, 2026]
- **V1.4: Request body size limits** (ServQueue, ServConsole, ServCache, ServMesh, ServCron, ServCloud, ServTrace, ServTunnel, ServAuth, ServPool, ServMail, ServFlow) — Add `http.MaxBytesReader` (default 10MB). Prevents memory exhaustion. [July 17, 2026]
- **V1.5: CORS headers on all services** (All except ServStore) — Add `Access-Control-Allow-Origin` for browser-based clients (configurable via env var). [July 17, 2026]
- **V1.6: `/api/version` on ServConsole** (ServConsole) — Only service missing the version endpoint. [July 17, 2026]
- **V1.7: STABILITY.md** — Document what's guaranteed stable (S3 API, STOMP, OAuth endpoints, CLI flags) vs experimental (internal service APIs). [July 17, 2026]
- **V1.8: UPGRADING.md** — Migration guide template: how to upgrade between major versions, what might break, deprecation timeline. [July 17, 2026]
- **V1.10: CHANGELOG.md standardization** — Every component gets a Keep-a-Changelog format CHANGELOG. Required for v1.0 credibility. [July 17, 2026]
- **V1.11: v1.0.0 release notes draft** — Comprehensive release announcement covering all 19 components, key features, migration notes. [July 17, 2026]
- **V1.12: Docker Hub / GHCR images** — Publish official container images for all services (`ghcr.io/vyuvaraj/servstore:1.0.0`). [July 17, 2026]
- **V1.14: VS Code extension published** — Publish LSP extension to marketplace before v1.0 tag. Signals production readiness. [July 17, 2026]
- **V1.15: VS Code extension enhancements** — Implement robust cross-platform shell terminal escaping, regex-based CodeLens detection, diagnostics cleanup on file close, and colocated LSP path autodetect. [July 17, 2026]

## Phase 28: Distribution & Installer Packaging (Completed Items)

Move beyond GitHub zip downloads to proper OS-native installers across Windows, macOS, and Linux. Deliver a frictionless install experience for new users.

### Current Baseline

| Channel | Status | Notes |
|---|---|---|
| GitHub Release zips | ✅ Live | All 16 services, via GoReleaser |
| Homebrew tap | ✅ Live | `brew install vyuvaraj/serv/<service>` |
| Scoop bucket | ✅ Live | `scoop install <service>` |
| Docker / GHCR | ✅ Live | `ghcr.io/vyuvaraj/<service>:latest` |
| `.deb` / `.rpm` packages | ✅ Live | Generated via GoReleaser + nfpm |
| Windows setup `.exe` | ✅ Live | Created via Inno Setup (`servverse.iss`) |
| macOS `.pkg` installer | ✅ Live | Built via `build-macos-pkg.sh` |
| Snap / Microsoft Store | ✅ Live | Created snapcraft.yaml & AppxManifest.xml |

### Phase 1 - Linux Packages via nfpm

- **PKG.1: Add `nfpms` block to all 17 GoReleaser configs** — Generates `.deb` (Ubuntu/Debian/Mint) and `.rpm` (RHEL/Fedora/Rocky) packages in every GitHub Release automatically. Handles `/usr/local/bin` placement, package metadata, and checksums. [July 17, 2026]
- **PKG.2: Per-service postinstall scripts** — `postinstall.sh` prints quick-start instructions; `preremove.sh` stops any running service instance before uninstall. [July 17, 2026]
- **PKG.3: Unified ServVerse `.deb` / `.rpm` meta-package** — A single `servverse` meta-package that declares all 16 services as dependencies, so `apt install servverse` installs the full stack. [July 17, 2026]

### Phase 2 - Windows Unified Installer (Inno Setup)

- **PKG.4: Inno Setup script for `ServVerse-x.x.x-windows-setup.exe`** — Single installer with component picker. User selects which services to install. Handles PATH addition, Start Menu shortcuts, and Add/Remove Programs uninstall entry. [July 17, 2026]
- **PKG.5: GitHub Actions workflow for Windows installer build** — Automates Inno Setup build on each release tag using `crazy-max/ghaction-setup-inno`. Uploads the `.exe` as a release asset. [July 17, 2026]
- **PKG.6: Chocolatey package** — Submit `servverse.nuspec` to Chocolatey Community Repository for `choco install servverse`. [July 17, 2026]
- **PKG.7: winget manifest** — Submit manifest to `microsoft/winget-pkgs` for `winget install Yuvaraj.ServVerse`. [July 17, 2026]

### Phase 3 - macOS Packaging (Signed & Notarized)

- **PKG.8: macOS `.pkg` via `pkgbuild` + `productbuild`** — Installs all selected binaries to `/usr/local/bin`. Signed and notarized for macOS 10.15+ Gatekeeper compatibility. [July 17, 2026]
- **PKG.9: Apple Developer notarization in CI** — Automate `xcrun notarytool submit` in GitHub Actions after `pkgbuild`. Requires Apple Developer account secrets in repo settings. [July 17, 2026]

### Phase 4 - Store Distribution

- **PKG.10: Snap package (`snapcraft.yaml`)** — Works across all Linux distros without `.deb`/`.rpm`. Published to Snap Store. [July 17, 2026]
- **PKG.11: MSIX for Microsoft Store** — Modern Windows packaging format. Required for Microsoft Store listing and enterprise GPO deployment. Requires EV code-signing certificate. [July 17, 2026]

---

## Phase 29: LSP IntelliSense & Developer Tooling (Completed Items)

Make the Serv-lang VS Code extension feel truly first-class - on par with TypeScript/Rust Analyzer. Each item directly reduces friction for developers writing `.srv` files daily.

### Core IntelliSense & Hover Polish

- **DX.1: `insertTextFormat: 2` on all completion items** — Enable tab-stop placeholders (`$1`, `$2`) in all completions so pressing Tab cycles through arguments. [July 17, 2026]
- **DX.2: Signature help for built-in namespace calls** — Typing `log.info(` or `db.query(` shows the parameter signature tooltip. [July 17, 2026]
- **DX.3: Snippet completions for block keywords** — Typing `route`, `fn`, `test`, `struct`, `every`, `cron`, `subscribe` expands to a full multi-line snippet with correct body scaffold. [July 17, 2026]
- **DX.4: Import path auto-complete** — Inside `import "..."`, suggest relative `.srv` files from the workspace by scanning the file tree. [July 17, 2026]
- **DX.5: Struct field member completions** — If `let u = User { ... }` is parsed, typing `u.` suggests the struct's declared fields. [July 17, 2026]
- **DX.6: Hover docs for namespace members** — Hovering on `.info` in `log.info(...)` shows member-level documentation. [July 17, 2026]
- **DX.7: `match` arm completions for enums** — Inside a `match` block on a known enum variable, suggest all variant arms automatically. [July 17, 2026]
- **DX.8: Completion sort order** — Local document symbols first, built-in namespaces second, keywords last using `sortText` field. [July 17, 2026]
- **DX.9: `documentation` field on completions** — Add markdown usage examples to built-in completion items. [July 17, 2026]

### Developer Tooling & Advanced Features

- **DX.10: Inlay type hints** (`textDocument/inlayHint`) — Ghost text showing inferred variable types next to `let` declarations without hover. [July 17, 2026]
- **DX.11: Code lens for test blocks** (`textDocument/codeLens`) — Show `? Run test` clickable lens above every `test "..."` block. [July 17, 2026]
- **DX.12: Code lens for route blocks** — Show `? Send request` lens above every `route` declaration that opens a request panel. [July 17, 2026]
- **DX.13: `textDocument/selectionRange`** — Smart expand/shrink selection to nearest statement or block boundary. [July 17, 2026]
- **DX.14: AI-powered completion** — POST last N lines to `ai.complete` endpoint for context-aware suggestions. [July 17, 2026]
- **DX.15: Live route linting** — Warn on `route` blocks with no `return` on all code paths. [July 17, 2026]
- **DX.16: `serv://` link navigation** — Clicking a `serv://service/path` string in any `.srv` file triggers Go-to-Definition. [July 17, 2026]
