# Headless / Backend-Only Service Mode

OpenGeoForge is first a geospatial backend platform. A frontend is optional.

## Deployment modes

### Full reference product
```text
OpenGeoForge backend + Expo/web reference client
```

### Headless
```text
OpenGeoForge backend only
customer web/mobile/desktop/GIS client
```

### Internal platform
```text
product backend -> OpenGeoForge private APIs/maps
```

The backend contract remains independent of the reference React/Expo client.

## Public API surface

Suggested families:

```text
/api/v1/layers
/api/v1/layers/{layerId}

/api/v1/features/{layerId}
/api/v1/features/{layerId}/{featureId}

/api/v1/identify
/api/v1/query
/api/v1/statistics

/api/v1/geometry/validate
/api/v1/geometry/transform

/api/v1/imports
/api/v1/exports

/maps/mvt/{layerId}/{z}/{x}/{y}.pbf
/maps/wmts/...
/maps/wms/...

/health/live
/health/ready
```

## Formats

GeoJSON:
```http
Content-Type: application/geo+json
```

MVT:
```http
Content-Type: application/vnd.mapbox-vector-tile
```

Esri interoperability must be explicit via documented endpoint/profile/content negotiation.

Do not return Esri JSON and GeoJSON ambiguously from the same contract.

## OpenAPI

The application API must publish/version an OpenAPI document.

Use it to generate TypeScript clients/types for the reference frontend.

GeoServer REST/admin endpoints are never included in public OpenAPI.

## Authentication

Support OIDC/OAuth2/JWT for user/app access where appropriate.

Server-to-server clients get separately scoped credentials.

API keys, if supported, require:
- scopes;
- rotation;
- hashing/storage policy;
- rate limits;
- audit.

## CORS

Headless deployment needs explicit allowed origins.

Never ship unrestricted credentialed CORS.

## Query safety

Clients never send raw SQL or unrestricted CQL/ECQL.

Bound:
- bbox;
- time range;
- row/feature count;
- geometry vertices;
- image dimensions;
- export size;
- expensive concurrent jobs.

## HTTP caching

Use ETag/Cache-Control/conditional GET where safe.

Tenant/private data must never leak through a shared cache key.

## Concurrency

Use one documented optimistic concurrency strategy consistently.

Stale edits return 409 Conflict, or use an explicit ETag/If-Match model if adopted by ADR.

## Independence

No backend slice may require the Expo frontend to be deployed.
