# Geometry Interoperability Model

OpenGeoForge supports three distinct concerns:

1. **PostGIS / NetTopologySuite** — canonical internal spatial model.
2. **GeoJSON (RFC 7946)** — default open application/API interchange.
3. **Esri JSON / ArcGIS REST geometry** — explicit interoperability adapter.
4. **OpenLayers** — browser-side geometry, rendering and editing client.

These are not interchangeable wire formats. Conversion must be deliberate.

## Canonical policy

```text
PostGIS / NetTopologySuite
        |
        +--> RFC 7946 GeoJSON --> public application APIs
        |
        +--> Esri JSON --------> ArcGIS interoperability
        |
        +--> MVT/WMTS/WMS -----> rendering
```

OpenLayers consumes the public contracts and may read/write GeoJSON or EsriJSON, but it is not the canonical storage model.

## Geometry mapping

| Canonical concept | GeoJSON | Esri JSON | OpenLayers |
|---|---|---|---|
| Point | `Point` | `{x,y,...}` | `Point` |
| MultiPoint | `MultiPoint` | `points` | `MultiPoint` |
| Line | `LineString` | one `paths[]` path | `LineString` |
| Multipart line | `MultiLineString` | multiple `paths[]` | `MultiLineString` |
| Polygon | `Polygon` | `rings[]` | `Polygon` |
| Multipart polygon | `MultiPolygon` | one Esri Polygon with multiple shell rings | `MultiPolygon` after reconstruction |
| Bounding box | `bbox` metadata, not a geometry type | `Envelope` | `Extent` array |
| Collection | `GeometryCollection` | no direct equivalent geometry object | `GeometryCollection` |

## Critical polygon difference

GeoJSON explicitly nests Polygon and MultiPolygon topology.

Esri JSON uses a flat `rings` array for polygon parts. Exterior and interior rings are identified by Esri orientation conventions and topology/containment.

Therefore:

> Never convert Esri `rings` to GeoJSON merely by changing the property name to `coordinates`.

A robust adapter must:
1. verify/resolve spatial reference;
2. close rings if the input policy permits repair;
3. validate each ring structurally;
4. classify shell/hole candidates;
5. verify containment rather than trusting orientation alone;
6. attach holes to the correct shell;
7. identify disconnected shells;
8. produce Polygon or MultiPolygon;
9. validate the resulting OGC geometry;
10. normalize output winding for the destination format.

## One-path / one-shell normalization

OpenGeoForge canonicalizes:
- one Esri polyline path -> `LineString`;
- multiple Esri polyline paths -> `MultiLineString`;
- one Esri polygon shell (+ holes) -> `Polygon`;
- multiple disconnected shells -> `MultiPolygon`.

Do not change an established domain column type merely because one payload contains one part. Database schemas may intentionally use `MultiLineString` or `MultiPolygon` for stable cardinality.

## Feature mapping

### GeoJSON Feature
- `id`
- `geometry`
- `properties`

### ArcGIS/Esri Feature
- `geometry`
- `attributes`

Mapping rule:
- Esri `attributes` <-> GeoJSON `properties`;
- object/global IDs are mapped explicitly, not guessed;
- field aliases/types belong to schema metadata, not blindly copied into GeoJSON properties.

## Z and M

### Z
Both systems can carry Z, but meaning/units depend on the spatial reference and domain.

### M
Esri supports M explicitly via `hasM` and coordinate M values.

RFC 7946 does not define a standard M ordinate. A fourth coordinate must not be treated as a portable GeoJSON M contract.

When M matters:
- preserve it in PostGIS/NTS using an M-capable geometry model;
- expose Esri JSON for ArcGIS workflows; or
- define a separate documented application contract.

Do not silently drop M in a supposedly lossless conversion.

## Lossless vs lossy conversion

Every adapter must state whether conversion is:
- lossless;
- conditionally lossless;
- lossy.

Typical lossy cases:
- Esri M -> RFC 7946;
- Esri true curves -> linear GeoJSON without an explicit densification policy;
- vertical spatial-reference metadata -> plain RFC 7946;
- Esri precision/tolerance metadata -> plain GeoJSON;
- Esri Envelope -> GeoJSON geometry unless explicitly represented as Polygon.

## Authoritative sources

- RFC 7946: https://www.rfc-editor.org/rfc/rfc7946
- Esri geometry objects: https://developers.arcgis.com/rest/services-reference/enterprise/geometry-objects/
- Esri FeatureSet: https://developers.arcgis.com/rest/services-reference/enterprise/featureset-object/
- OpenLayers GeoJSON: https://openlayers.org/en/latest/apidoc/module-ol_format_GeoJSON-GeoJSON.html
- OpenLayers EsriJSON: https://openlayers.org/en/latest/apidoc/module-ol_format_EsriJSON-EsriJSON.html
