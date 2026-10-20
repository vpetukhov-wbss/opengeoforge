# Architecture Overview

OpenGeoForge separates application concerns from GIS infrastructure.

## Public boundary

The .NET Gateway is the public API.

Clients should not directly access:
- GeoServer administration;
- GeoServer REST configuration;
- PostgreSQL/PostGIS;
- Redis;
- GeoWebCache administrative APIs.

## Runtime components

### GeoGateway.Api
- authentication and authorization;
- application/tenant context;
- Vertical Slice use cases;
- GeoJSON contracts;
- bounded spatial queries;
- approved WMS/WMTS/MVT proxy routes;
- editing, auditing and concurrency;
- rate limiting;
- OpenTelemetry.

### PostgreSQL/PostGIS
Canonical spatial source of truth.

### GeoServer
Private rendering and OGC interoperability engine.

### GeoWebCache
Tile caching for stable/high-read map products.

### Redis
Short-lived application cache, coordination and invalidation messaging.

### Worker
Long-running imports, exports, materialized-view refreshes, cache jobs and maintenance.

## gRPC

GeoServer itself is not treated as a gRPC server.

Use:
- HTTP/OGC/REST between OpenGeoForge and GeoServer;
- Npgsql between .NET and PostGIS;
- gRPC only for justified internal .NET service boundaries.

Start in-process when a boundary does not yet need a separate deployment.
