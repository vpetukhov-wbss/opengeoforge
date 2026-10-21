# RFC 7946 GeoJSON Profile

GeoJSON is OpenGeoForge's default public feature interchange format.

## Allowed geometry types

- Point
- MultiPoint
- LineString
- MultiLineString
- Polygon
- MultiPolygon
- GeometryCollection

`Feature` and `FeatureCollection` wrap geometry and properties.

## Coordinate order

RFC 7946 positions are:

```text
[longitude, latitude]
[x, y]
```

For the public GeoJSON contract:

```json
[25.4858, 42.7339]
```

means longitude 25.4858, latitude 42.7339.

Do not swap this because a user interface labels fields "latitude / longitude".

## CRS

RFC 7946 uses WGS 84 longitude/latitude semantics (OGC CRS84-style coordinate order).

Do not emit the deprecated pre-RFC `crs` member.

If authoritative data is stored in another CRS:
1. validate its actual SRID;
2. transform with `ST_Transform` / an equivalent projection engine;
3. serialize the transformed coordinates as RFC 7946.

## Linear rings

A linear ring:
- is a closed LineString;
- has at least four positions;
- has identical first and last position values.

Example:

```json
[
  [25.30, 42.60],
  [25.40, 42.60],
  [25.40, 42.70],
  [25.30, 42.70],
  [25.30, 42.60]
]
```

Closing a ring does **not** prove polygon validity.

## Polygon structure

```text
coordinates[0] = exterior ring
coordinates[1..n] = holes
```

For canonical RFC 7946 output:
- exterior ring: counterclockwise;
- holes: clockwise.

Parsers should not reject otherwise valid legacy input solely because winding is reversed; writers should normalize canonical output.

## MultiPolygon

A MultiPolygon is an array of complete Polygon coordinate arrays.

Do not represent disconnected shells as extra rings of a single GeoJSON Polygon. Use `MultiPolygon`.

## bbox

For ordinary 2D GeoJSON:

```text
[west, south, east, north]
```

Do not casually rename this to an arbitrary CRS `minx,miny,maxx,maxy` concept without tracking the actual contract.

## Z and extra ordinates

A third ordinate can represent height/elevation.

RFC 7946 does not establish portable semantics for an M ordinate. OpenGeoForge does not publish a fourth coordinate as a standard M contract.

## GeometryCollection

Use GeometryCollection only when heterogeneous geometry is genuinely required.

Prefer domain-specific typed geometry columns/endpoints when possible.

## Antimeridian

GeoJSON that crosses the antimeridian needs special handling. Follow RFC 7946 guidance rather than drawing a segment the long way across the world.

Adapters/importers must test antimeridian cases for global datasets.

## API output rule

When OpenLayers writes canonical GeoJSON, use right-handed output:

```ts
format.writeFeatureObject(feature, {
  featureProjection: map.getView().getProjection(),
  dataProjection: 'EPSG:4326',
  rightHanded: true
});
```

## Authoritative source

https://www.rfc-editor.org/rfc/rfc7946
