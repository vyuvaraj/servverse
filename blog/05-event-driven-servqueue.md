# Event-Driven Microservices with ServQueue

> **Published:** July 2026 | **Reading Time:** ~12 min | **Tags:** `servqueue`, `messaging`, `event-driven`, `pub-sub`

---

Synchronous request-response works fine until it doesn't. When a user places an order, you don't want them waiting while your service sends a confirmation email, updates inventory, triggers a fulfillment workflow, and notifies your analytics pipeline — all in sequence. **ServQueue** decouples these operations so each one runs independently and reliably.

---

## What Is ServQueue?

ServQueue is the Servverse message broker. It supports:

- **Pub/Sub** — fan out messages to multiple subscribers
- **Task queues** — guaranteed at-least-once delivery with retry
- **Dead letter queues** — capture messages that fail repeatedly
- **Delayed delivery** — schedule a message for the future
- **STOMP protocol** — compatible with existing STOMP clients

---

## Step 1: Start ServQueue

```bash
docker run -d \
  -p 8083:8083 \
  -v servqueue_data:/data \
  --name servqueue \
  ghcr.io/vyuvaraj/servqueue:latest
```

---

## Step 2: Core Concepts

### Topics vs Queues

| Type | Behavior | Use case |
|------|----------|---------|
| **Topic** | Fan-out to all subscribers | Notifications, analytics events |
| **Queue** | Single consumer, with retry | Background jobs, task processing |

### Message Anatomy

```json
{
  "id": "msg_01J...",
  "topic": "orders.created",
  "payload": { "order_id": "ord_123", "user_id": "usr_456", "total": 99.99 },
  "metadata": {
    "retry_count": 0,
    "max_retries": 3,
    "delay_until": null,
    "created_at": "2026-07-10T11:00:00Z"
  }
}
```

---

## Step 3: Publish a Message

```bash
curl -X POST http://localhost:8083/publish \
  -H "Content-Type: application/json" \
  -d '{
    "topic": "orders.created",
    "payload": {
      "order_id": "ord_123",
      "user_id": "usr_456",
      "total": 99.99,
      "items": [{"sku":"WIDGET","qty":2}]
    }
  }'
```

Response:
```json
{"message_id": "msg_01J9X...", "topic": "orders.created", "queued": true}
```

---

## Step 4: Subscribe and Consume

### REST Long-Poll Subscriber

```bash
# Subscribe and wait for next message (up to 30s)
curl "http://localhost:8083/subscribe/orders.created?consumer=email-service&timeout=30s"
```

### Webhook Subscriber

Register a webhook endpoint that ServQueue calls when a message arrives:

```bash
curl -X POST http://localhost:8083/subscriptions \
  -H "Content-Type: application/json" \
  -d '{
    "topic": "orders.created",
    "consumer_group": "email-service",
    "delivery": {
      "type": "webhook",
      "url": "http://email-service:3010/hooks/order-created",
      "secret": "webhook-secret-here"
    },
    "retry": {
      "max_attempts": 3,
      "backoff": "exponential",
      "initial_delay": "1s"
    }
  }'
```

Now every `orders.created` message will be POSTed to your email service automatically.

---

## Step 5: Build an Event-Driven Order Flow

Here's the full architecture for an order processing system:

```
POST /api/orders
     │
     ▼
OrderService
     │  publishes "orders.created"
     ▼
ServQueue (orders.created topic)
     ├─── EmailService ──────> Sends confirmation email
     ├─── InventoryService ──> Decrements stock
     ├─── AnalyticsService ──> Records conversion event
     └─── FulfillmentService > Triggers shipment workflow
```

Each consumer is fully independent. If AnalyticsService is down, orders still process. When it comes back, ServQueue replays the missed messages.

### OrderService (publishes the event)

```serv
import queue

service OrderService {
  route POST /orders {
    validate body(Order)
    order = store.create(Order, body)
    
    # Fire and forget — don't wait for downstream
    queue.publish("orders.created", {
      order_id: order.id,
      user_id:  order.user_id,
      total:    order.total,
      items:    order.items
    })
    
    return order
  }
}
```

### EmailService (consumes the event)

```serv
import queue
import mail

service EmailService {
  consumer "orders.created" {
    group   "email-service"
    retries 3

    handler(msg) {
      user = store.get(User, msg.user_id)
      mail.send({
        to:      user.email,
        subject: "Order Confirmed — #${msg.order_id}",
        template: "order-confirmation",
        data:     msg
      })
    }
  }
}
```

---

## Step 6: Delayed Messages

Schedule a message for delivery in the future — perfect for reminders and follow-ups:

```bash
# Send an "abandon cart" reminder in 1 hour
curl -X POST http://localhost:8083/publish \
  -d '{
    "topic": "cart.reminder",
    "payload": {"user_id": "usr_456", "cart_id": "cart_789"},
    "delay": "1h"
  }'
```

---

## Step 7: Dead Letter Queue

Messages that fail all retries land in a dead letter queue (DLQ) for inspection:

```bash
# View DLQ messages
curl http://localhost:8083/dlq/orders.created

# Replay a failed message
curl -X POST http://localhost:8083/dlq/orders.created/msg_01J9X.../replay
```

---

## Step 8: Multi-Topic Fan-out Pattern

For high-throughput systems, use topic hierarchies with wildcards:

```bash
# Subscribe to ALL order events
curl -X POST http://localhost:8083/subscriptions \
  -d '{
    "topic": "orders.*",          # Matches orders.created, orders.shipped, orders.cancelled
    "consumer_group": "audit-log",
    "delivery": { "type": "webhook", "url": "http://audit:3020/events" }
  }'
```

---

## Reliability Guarantees

| Guarantee | ServQueue Behavior |
|-----------|------------------|
| **At-least-once delivery** | Messages retried until ACKed by consumer |
| **Ordering** | Per-partition ordering within a consumer group |
| **Durability** | Messages persisted to disk before ACK returned to publisher |
| **Replay** | Consumers can rewind and replay from any offset |

---

## What's Next?

We've covered gateway, caching, and messaging. In the final post, we tie everything together and build a complete SaaS application using 8+ Servverse components in under an hour.

➡️ [Full-Stack SaaS in Under an Hour with Servverse](./06-fullstack-saas-servverse.md)

---

*Questions about ServQueue patterns? Join the discussion at [ServQueue/discussions](https://github.com/vyuvaraj/ServQueue/discussions).*
