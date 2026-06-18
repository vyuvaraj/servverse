# Servverse Ecosystem Showcase Guide

This guide provides step-by-step instructions to showcase the complete **Servverse** ecosystem in action. You will run a multi-component microservices environment, configure dynamic routing, hot-swap WebAssembly stream transforms, explore consistent hash rings, and view nested trace waterfalls.

---

## Prerequisites
* **Docker** and **Docker Compose** installed.
* A terminal client (e.g. Git Bash, PowerShell, or terminal) with `curl` installed.

---

## 1. Launch the Ecosystem
From the root of the workspace directory, run:

```bash
docker compose up --build
```

This compiles all local projects and spins up:
* **Jaeger** (`:16686`): Observability collector and trace engine.
* **ServStore** (`:8081`): Distributed object storage.
* **ServQueue** (`:8082`, `:61613`): WASM-enabled STOMP message broker.
* **ServGate** (`:8080`): API Gateway proxy.
* **ServConsole** (`:8083`): Glassmorphic management console.
* **ServRegistry** (`:8088`): Community package registry.

---

## 2. Step-by-Step Showcase Flow

### Step 1: Explore the Console (ServConsole)
1. Open your browser and navigate to `http://localhost:8083`.
2. Inspect the **Status Summary** cards in the upper-right corner. You will see green **ONLINE** badges for `ServGate`, `ServQueue`, and `ServStore`, along with their live connection latencies.
3. Check the active configuration by looking at the default proxy routes.

### Step 2: Dynamic Route Setup & Audit Logging
1. In the **Gateways** tab, click **+ Add Route**.
2. Register a new route:
   * **Path Prefix**: `/api/v1/tasks`
   * **Target URL**: `http://localhost:8081/console/metrics` (proxying to ServStore metadata)
   * Toggle **PII Redactor** to active.
   * Click **Register Route**.
3. Observe that the route appears in the table.
4. Navigate to the **Audit Logs** tab. You will see an immutable entry:
   `[TIMESTAMP] anonymous | Register/Update API Route: /api/v1/tasks | POST | /api/routes | 200`
5. ServGate automatically syncs this configuration from its ServStore backend bucket and reloads routes in memory without restarting.

### Step 3: Hot-Swap WASM Stream Processing (ServQueue)
1. Navigate to the **Queues** tab in the dashboard.
2. In the **Register Transform Filter** form, enter a topic name (e.g., `orders`).
3. You can compile a test WASM filter from the `ServQueue` directory:
   ```bash
   # Build a quick transform
   cd ServQueue/pkg/broker
   # (Alternatively, select any pre-built .wasm file in the workspace)
   ```
4. Upload the compiled `.wasm` file. ServQueue will load and run it sandboxed inside its routing engine.
5. In the **Publish Test Message** card, enter:
   * **Topic**: `orders`
   * **JSON Payload**: `{"item": "laptop", "quantity": 1}`
6. Click **Publish Message**. The broker receives, transforms, and delivers it.

### Step 4: Storage Clustering & Consistent Hash Ring (ServStore)
1. Navigate to the **Storage** tab.
2. Inspect the **Consistent Hash Ring** visualizer. It renders an interactive map representing key distributions across storage peers.
3. Select an existing bucket (e.g., `media-assets`) to inspect file objects.
4. In the rebalance card, click **⚡ Trigger Cluster Rebalance**. The console triggers a gossip round across nodes.
5. Go to the **Audit Logs** tab to verify that the rebalance action is logged.

### Step 5: End-to-End Tracing Waterfall
1. Navigate to the **Telemetry & Traces** tab.
2. Click **Refresh Traces**.
3. Select a recent trace (e.g., corresponding to the message publish or route update).
4. Inspect the **OTel Waterfall Chart**, displaying the cascading delay across network and process boundaries (Gateway ➔ Queue ➔ Storage) with accurate microsecond latency.

### Step 6: Package Registry & CLI Integration (ServRegistry)
1. Open your browser and navigate to the premium package registry dashboard at `http://localhost:8088`. You will see the **ServRegistry** interface.
2. In your terminal, publish the `stdlib` module using the Serv-lang CLI (pointing it to the local registry):
   ```bash
   $env:SERV_REGISTRY="http://localhost:8088"
   cd Serv-lang
   .\serv.exe publish stdlib
   ```
3. Refresh the `ServRegistry` dashboard at `http://localhost:8088`. You will see the `stdlib` package listed with its size, publish date, and a copyable install command.
4. Try installing the package:
   ```bash
   .\serv.exe install stdlib
   ```
   Observe the package successfully downloads and extracts to your local directory.

### Step 7: Zero-Config Microservice Self-Announcement (servgate://)
1. Launch the `showcase/task-api` microservice (which uses `servgate://` route registration in its `main.srv` file):
   ```bash
   cd showcase/task-api
   ..\..\Serv-lang\serv.exe run main.srv
   ```
2. Observe the startup logs showing that the service automatically extracted its routes and sent a self-announcement call to `ServGate`.
3. Open `ServConsole` at `http://localhost:8083` and go to the **Gateways** tab. Observe that the `/api/tasks` and `/api/stats` routes have been dynamically registered with target `http://localhost:3000`.
4. Try requesting a route via the Gateway:
   ```bash
   curl http://localhost:8080/api/tasks
   ```
   Observe that the gateway proxies the request directly to the running `task-api` microservice and returns the task list.
5. Check the **Audit Logs** tab in `ServConsole` to verify that the route self-announcement was recorded as an audit event.
