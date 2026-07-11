# Scheduled Jobs & Reliable Mail Queues: ServCron and ServMail

Modern backend applications rarely exist as simple request-response APIs. Almost every system eventually requires asynchronous job schedulers (cron jobs) and transactional mail pipelines. 

In the Servverse ecosystem, these asynchronous needs are fulfilled by two highly optimized services: **ServCron** (for consensus-driven cron tasks) and **ServMail** (for durable transactional mail queues).

---

## ⏰ ServCron: Distributed Scheduling Without Double-Execution

Running a cron scheduler is straightforward on a single server, but it becomes challenging in a containerized cluster. If you run three instances of your service, a job scheduled for midnight might execute three times.

ServCron solves this by integrating a distributed leader election provider:

```go
type LeaderElectionProvider interface {
    Start()
    Stop()
    IsLeader() bool
    AcquireJobLock(jobID string, nextRun time.Time) bool
}
```

### How Leader Election Works

1. **Raft/Redis Consensus**: Nodes register their availability and lease a lease duration lock.
2. **Leader Selection**: Only the elected Leader node evaluates cron expressions and triggers job instances.
3. **Execution Locks**: Before a job starts, the scheduler acquires a distributed slot lock. This prevents duplicate executions even if the network splits.

Downstream worker execution reports are gathered and streamed directly to the **ServConsole** dashboard for monitoring.

---

## 📧 ServMail: Transactional Mail with Local Disk Backup

A transactional mail service must be durable. If a registration email fail to send due to a temporary network timeout, it should retry and fallback, rather than being silently dropped.

ServMail provides reliable outbound mail delivery via a local ring-buffer disk queue:

1. **Memory Queue**: Outbound mail is received and immediately queued in-memory for rapid client returns.
2. **Disk Queue Serialization**: Simultaneously, the envelope is appended to a local JSONL queue file (`mail-queue.jsonl`) to survive crashes.
3. **DKIM Outbound Signing**: Outgoing headers are dynamically signed using domain keys (DKIM) to ensure high delivery success rates.
4. **Dead Letter Queue (DLQ)**: If delivery fails after three retries, the message is archived in the DLQ for operator inspection.

---

## Summary

By leveraging ServCron and ServMail, developers can offload complex clustering concerns (distributed locking, consensus scheduling) and email delivery requirements (DKIM signing, local disk queuing) to dedicated, production-ready modules.
