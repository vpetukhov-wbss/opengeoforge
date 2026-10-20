# Production Deployment

OpenGeoForge can run on one Ubuntu host for development and private/low-SLA workloads, but a single machine is not highly available.

## Private services

Do not publish host ports for:
- PostgreSQL;
- Redis;
- GeoServer;
- GeoWebCache admin endpoints.

Only the public edge/Gateway should be reachable from the internet.

## Production requirements

- exact/pinned component versions;
- external GeoServer data directory;
- least-privilege database roles;
- GeoServer rendering account read-only by default;
- GeoWebCache disk quota;
- TLS;
- secrets outside Git;
- backups off-host;
- tested restore procedure;
- metrics/logs/traces;
- capacity alerts;
- rollback procedure.

## Data durability

Critical:
- PostgreSQL/PostGIS;
- GeoServer configuration/data directory;
- provisioning/style sources;
- secret-management recovery material.

Normally rebuildable:
- GeoWebCache tiles;
- Redis cache;
- generated exports.

## Scale path

1. single-node development/reference deployment;
2. dedicated/managed PostgreSQL;
3. separate Gateway/GeoServer hosts;
4. multiple replicas when real load/availability requires them.
