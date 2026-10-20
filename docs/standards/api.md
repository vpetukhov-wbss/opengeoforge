# API Standards

## Versioning

Public application APIs begin under:

```text
/api/v1/
```

Map delivery is separate:

```text
/maps/wms
/maps/wmts
/maps/mvt
```

## Feature interchange

Use:
```http
Content-Type: application/geo+json
```

for GeoJSON Feature/FeatureCollection contracts.

## Query rules

Prefer explicit parameters:
- bbox;
- zoom;
- time range;
- page/cursor;
- known filter names and values.

Do not expose an unrestricted arbitrary CQL/ECQL pass-through.

## Errors

Use Problem Details-compatible JSON for application API errors.

Geometry validation errors should identify:
- field/feature;
- error code;
- human-readable reason;
- invalid location when safe/useful.

## Concurrency

Mutable features carry a version token. Stale updates return HTTP 409 Conflict.
