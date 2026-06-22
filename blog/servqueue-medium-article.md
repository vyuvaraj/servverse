# I Built a Message Broker With Inline WASM Stream Processing — From Scratch

*How ServQueue combines STOMP messaging, sliding-window deduplication, Dead Letter Queues, and serverless WebAssembly transforms.*

---

## The Stream Processing Problem

Message brokers like RabbitMQ, NATS, or Kafka do an excellent job of delivering bytes from producer to consumer. But they are fundamentally passive pipelines.

If you need to transform a message (e.g., uppercase a string, filter out spam, or format JSON) before it reaches the consumer, you have to spin up a separate stream processor (like Apache Flink, Kafka Streams, or a custom worker). This adds network hops, deployment complexity, and infrastructure cost.

What if your message broker could process streams *internally*? What if you could write a lightweight filter in Go or Rust, compile it to WebAssembly (WASM), and execute it inside the message broker's dispatch loop with absolute isolation?

This is why I built ServQueue.

---

## What is ServQueue?

ServQueue is a lightweight, high-performance message broker written in Go, specifically designed for the **Servverse** ecosystem. It supports the industry-standard **STOMP (Simple Text Oriented Messaging Protocol)** protocol, meaning standard STOMP clients in Python, Node.js, Java, and Go connect out of the box.

But the core differentiator is **Compute-in-Queue**:

```
Producer ➔ [ Publish ] ➔ ( ServQueue Topic ) ➔ [ WASM Transform ] ➔ [ Dispatch ] ➔ Consumer
                                                      │
                                             (Failed / Dropped)
                                                      │
                                                      ▼
                                            ( Dead Letter Queue )
```

Beyond standard pub/sub routing, ServQueue implements:
- **WASM Stream Transformers**: Sandboxed event transformation running on the server-side via `wazero`.
- **Dead Letter Queues (DLQ)**: Automatic routing of malformed messages or failed transformations.
- **Sliding-Window Deduplication**: Built-in protection against duplicate publications using unique message hashes.
- **Persistent Write-Ahead Log (WAL)**: Crash-resilient message storage.

---

## Compute-in-Queue: How Inline Transforms Work

Imagine you have a topic called `raw-events` and you want to ensure all incoming payloads are capitalized and cleaned of spaces before reaching subscribers on `processed-events`.

Instead of writing a consumer microservice, you write a WASM transformer in Go:

```go
package main

import (
	"strings"
	"github.com/vyuvaraj/servqueue/pkg/sdk"
)

func main() {
	sdk.RegisterTransform(func(msg string) (string, error) {
		// Capitalize payload
		trimmed := strings.TrimSpace(msg)
		return strings.ToUpper(trimmed), nil
	})
}
```

Compile the Go file to a WASM binary:

```bash
GOOS=wasip1 GOARCH=wasm go build -o transform.wasm main.go
```

Upload the WASM binary directly to the topic configuration:

```bash
curl -X POST http://localhost:8082/api/topics/raw-events/transform \
  --data-binary @transform.wasm
```

Now, every message sent to `raw-events` passes through the `wazero` WASM sandbox. The transformed payload is then dispatched to subscribers. If the transform returns an error or crashes, the broker routes the original payload to the registered Dead Letter Queue (DLQ).

---

## Dead Letter Queues (DLQ)

Failures are inevitable. A JSON parser fails, a WASM transform runs out of memory, or a client times out.

ServQueue handles this with native Dead Letter Queues. When registering a source topic, you can attach a DLQ destination:

```bash
# Register a DLQ for the 'orders' topic
curl -X POST http://localhost:8082/api/topics/orders/dlq \
  -H "Content-Type: application/json" \
  -d '{"dlq_topic": "orders.dlq"}'
```

If a message published to `orders` fails processing (e.g., due to a WASM transformation failure), the broker wraps the message in a diagnostic envelope and routes it to `orders.dlq`:

```json
{
  "dlq": true,
  "source_topic": "orders",
  "reason": "wasm execution error: out of memory",
  "payload": "{\"order_id\": 102}"
}
```

This prevents malformed messages from blocking your queues (head-of-line blocking) while preserving them for debugging and reprocessing.

---

## Sliding-Window Deduplication

In distributed systems, networks drop connections. Producres often retry publications, causing duplicate messages.

ServQueue provides sliding-window deduplication out-of-the-box. When publishing a message, you can supply a `X-Message-ID` or a deduplication key. ServQueue maintains a time-bound ring buffer of recently processed keys:

```bash
# Publish with a unique message ID
curl -X POST http://localhost:8082/api/publish \
  -H "Content-Type: application/json" \
  -d '{
    "topic": "billing",
    "payload": "invoice-9832",
    "dedup_key": "msg-uuid-9832"
  }'
```

If the producer retries the publication due to a network drop, ServQueue identifies the duplicate key within the configured window (e.g., 5 minutes) and drops it silently, returning a `200 OK` to ensure the producer stops retrying.

---

## How It Compares

| Feature | RabbitMQ | NATS JetStream | ServQueue |
|---------|----------|----------------|-----------|
| **Protocol** | AMQP / STOMP | NATS | STOMP / HTTP |
| **Compute-in-Queue** | ❌ (Plugins only) | ❌ | ✅ (WASM WASI) |
| **Deduplication** | Manual plugins | Stream deduplication | ✅ (Sliding Window) |
| **Dead Letter Queue** | ✅ | ✅ | ✅ (Auto-wrapped) |
| **Persistence** | Mnesia / Queue index | File / Memory | ✅ (Write-Ahead Log) |
| **Tracing** | Heavy configuration | Built-in | ✅ (OTel standard) |
| **Client Support** | Wide | Wide | ✅ (Standard STOMP) |

---

## Getting Started

### 1. Build and Run the Broker
Build the broker server:

```bash
# Clone the broker
git clone https://github.com/vyuvaraj/ServQueue.git
cd ServQueue

# Build and run
go build -o servqueue.exe main.go
./servqueue.exe
```

The **STOMP TCP Server** listens on `:61613` (standard STOMP port), and the **HTTP Management API** listens on `:8082`.

### 2. Connect via STOMP (Python Example)
You can consume messages from ServQueue using any standard STOMP client:

```python
import stomp
import time

class Listener(stomp.ConnectionListener):
    def on_message(self, frame):
        print(f"Received: {frame.body}")

conn = stomp.Connection([('127.0.0.1', 61613)])
conn.set_listener('', Listener())
conn.connect(wait=True)
conn.subscribe(destination='processed-events', id=1, ack='auto')

time.sleep(10)
conn.disconnect()
```

---

## What's Next

- **Distributed Raft Clustered Queues**: Share queue state across multiple nodes with strong consistency.
- **Delayed Message Delivery**: Schedule messages to be delivered at a specific time in the future.
- **Telemetry Visualizer**: Integrate directly with ServConsole to view queue depths and message flows in real-time.

---

## Links

- **GitHub**: [github.com/vyuvaraj/ServQueue](https://github.com/vyuvaraj/ServQueue)
- **Ecosystem Specs**: Check the full roadmap at `UNIFIED_ROADMAP.md` in the workspace root.
- **License**: Apache 2.0

---

*Streamline your infrastructure. Run transformations near the data inside the broker, handle failures gracefully with DLQs, and say goodbye to boilerplate processing pipelines.*

*— Yuvaraj*
