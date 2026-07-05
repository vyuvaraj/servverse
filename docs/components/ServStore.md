# ServStore — AI-Native Object Storage

> **Status:** ✅ Production | **Port:** 8081 | **Repository:** [ServStore](https://github.com/vyuvaraj/ServStore)

## Overview

S3-compatible distributed object storage with WASM transforms, semantic search, time-travel queries, and content-addressed deduplication. Single binary with embedded web console.

## Key Features

- Full S3-compatible API (PUT/GET/DELETE/HEAD, multipart, presigned URLs)
- Object versioning (enabled, suspended, disabled) + delete markers
- AWS Signature V4 authentication
- WASM server-side transforms (wazero runtime)
- Transform pipeline DAG (multi-stage chaining)
- Semantic search (HNSW vector index + ONNX embeddings)
- Multi-modal embedding (text, images, PDFs, audio)
- Time-travel queries (any object at any timestamp)
- Content-addressed storage with reference-counted GC
- Raft consensus for distributed metadata
- Erasure coding (Reed-Solomon)
- Consistent hashing for data placement
- Geo-aware data placement and replication
- Cold storage tiering (transparent rehydration from S3/Glacier/B2)
- S3 Select (SQL queries on CSV/JSON in-place)
- Bucket event notifications (CloudEvents)
- Object tagging and metadata
- Lifecycle policies (auto-expire/transition)
- Object locking (WORM)
- Kubernetes operator + CSI plugin
- Embedded web console (glassmorphic UI)

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVSTORE_PORT` | Listen port | `8081` |
| `SERVSTORE_DATA_DIR` | Storage directory | `./data` |
| `SERVSTORE_ACCESS_KEY` | S3 access key | `admin` |
| `SERVSTORE_SECRET_KEY` | S3 secret key | `password` |
| `SERV_OTLP_ENDPOINT` | OTel collector | (disabled) |

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /healthz` | Liveness probe |
| `PUT /<bucket>/<key>` | Upload object |
| `GET /<bucket>/<key>` | Download object |
| `GET /<bucket>?query=semantic&q=<text>` | Semantic search |
| `POST /<bucket>/<wasm>?transform=true` | Execute WASM transform |
| `GET /console/` | Web UI dashboard |

## Serv-lang Integration

```srv
store "servstore://localhost:8081/my-bucket"

route "POST" "/upload" (req) {
    store.put(req.body.filename, req.body.data)
    return { "stored": true }
}
```
