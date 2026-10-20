# OpenGeoForge Roadmap

The roadmap is outcome-oriented and may change based on real-world usage.

## v0.1 — Foundation
- repository/community baseline;
- architecture documentation;
- local Docker development stack;
- PostGIS + GeoServer + Redis;
- Claude project rules/agents;
- health checks.

## v0.2 — Spatial storage and publication
- PostGIS role model and migrations;
- GeoServer idempotent provisioning;
- reference workspaces/layers;
- initial SLD/CSS/YSLD examples;
- GeoWebCache quota and cache policy.

## v0.3 — Gateway and GeoJSON
- .NET 10 Minimal API Gateway;
- Vertical Slice baseline;
- RFC 7946 feature endpoints;
- authentication/authorization hooks;
- bounded spatial queries.

## v0.4 — Tiles and caching
- WMTS;
- MVT;
- Redis metadata/query cache;
- targeted cache invalidation;
- seed/truncate jobs.

## v0.5 — Editing
- geometry validation;
- optimistic concurrency;
- audit history;
- create/update/delete feature slices;
- safe polygon/line editing contracts.

## v0.6 — Imports and reference data
- Natural Earth;
- OpenStreetMap import pipeline;
- staging/validation/promotion workflow;
- import reporting.

## v0.7 — Operations
- OpenTelemetry;
- dashboards/alerts;
- backup/restore drill;
- performance baselines;
- security hardening.

## v0.8 — Application patterns
- utilities;
- properties/parcels;
- accidents/incidents;
- statistics/heatmaps;
- mobile/offline guidance.

## v0.9 — Production hardening
- upgrade/rollback automation;
- vulnerability gates;
- load tests;
- compatibility matrix;
- deployment reference architecture.

## v1.0 — Stable contracts
- stable API/extension policy;
- formal support policy;
- semantic versioning guarantees;
- production deployment documentation;
- upgrade guide.
