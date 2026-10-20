# Architecture Principles

## Open standards first
Prefer RFC/OGC formats and explicit adapters for vendor-specific formats.

## PostGIS is canonical
Persist geometry in native PostGIS geometry/geography columns, not GeoJSON JSONB as the primary store.

## GeoServer is infrastructure
GeoServer renders and publishes spatial data. It is not the public business API.

## Safe editing
Application edits pass through authentication, authorization, geometry validation, domain validation, optimistic concurrency, audit and cache invalidation.

## Bounded work
No unbounded map image dimensions, BBOX, exports, feature collections, filters, vertex counts or background jobs.

## Cache intentionally
GeoWebCache owns tile caching. Redis owns application-level ephemeral caching. Do not duplicate large tile stores.

## Vertical Slice Architecture
Keep feature behavior close together and avoid unnecessary service/repository abstraction layers.

## KISS / DRY / YAGNI
Do not introduce microservices, brokers or distributed complexity before a real requirement exists.
