# Geometry Standards

OpenGeoForge follows OGC/PostGIS validity semantics and RFC 7946 for public GeoJSON.

## Core distinctions

A geometry can be:
- **closed** but invalid;
- simple but not domain-correct;
- correctly oriented but invalid;
- valid but unacceptable for a specific domain.

Do not use these terms interchangeably.

## GeoJSON

Default public interchange:
- RFC 7946;
- longitude, latitude coordinate order;
- WGS 84 / CRS84 semantics;
- polygon rings explicitly closed;
- canonical exterior counterclockwise and holes clockwise on output.

## PostGIS

- native geometry/geography columns are canonical;
- enforce SRID and geometry type;
- add spatial indexes;
- use `ST_Transform` to transform coordinates;
- never use `ST_SetSRID` as a fake transform.

## Polygon writes

Validate:
1. structure;
2. finite coordinates;
3. minimum distinct vertices;
4. ring closure;
5. non-zero area;
6. self-intersections;
7. holes;
8. `ST_IsValid`;
9. domain-specific rules.

Never silently run `ST_MakeValid`, snapping, simplify or precision reduction on user data.

## Esri interoperability

Esri polygon winding conventions may differ from canonical GeoJSON output. Treat Esri JSON as an explicit adapter boundary, not the internal canonical representation.

## Interoperability profiles

The detailed format-specific rules are maintained separately:

- [RFC 7946 GeoJSON profile](geojson.md)
- [Esri JSON / ArcGIS geometry rules](esri-json.md)
- [Geometry interoperability model](interoperability.md)
- [CRS and axis-order rules](crs-axis-order.md)
- [OpenLayers client rules](../frontend/openlayers.md)

### Canonical boundary

```text
PostGIS / NetTopologySuite = canonical geometry
GeoJSON                  = default public API format
Esri JSON                = ArcGIS interoperability adapter
OpenLayers               = browser geometry/render/edit client
```

No format conversion may silently change CRS, polygon topology, Z/M dimensionality or curve semantics.
