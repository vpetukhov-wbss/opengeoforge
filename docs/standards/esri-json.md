# Esri JSON / ArcGIS Geometry Rules

Esri JSON is an interoperability format for ArcGIS REST ecosystems. It is not treated as equivalent to RFC 7946 GeoJSON.

## Spatial reference

Esri geometry can include:

```json
{
  "spatialReference": {
    "wkid": 102100,
    "latestWkid": 3857
  }
}
```

Spatial reference may be represented using:
- `wkid`;
- `latestWkid`;
- WKT;
- vertical coordinate-system identifiers/definitions.

Important:
- legacy WKIDs can coexist with a newer `latestWkid`;
- do not assume every Esri payload is EPSG:4326;
- do not discard vertical CRS information when Z is important.

## Point

Typical structure:

```json
{
  "x": 25.4858,
  "y": 42.7339,
  "spatialReference": { "wkid": 4326 }
}
```

Optional Z/M values can also be present.

## Multipoint

```json
{
  "points": [
    [25.48, 42.73],
    [25.49, 42.74]
  ],
  "spatialReference": { "wkid": 4326 }
}
```

## Polyline

Esri uses `paths`:

```json
{
  "paths": [
    [[25.48, 42.73], [25.49, 42.74]],
    [[25.60, 42.80], [25.61, 42.81]]
  ]
}
```

Mapping:
- one path -> LineString;
- multiple paths -> MultiLineString.

Do not merge disconnected paths into one line.

## Polygon

Esri uses `rings`:

```json
{
  "rings": [
    [...],
    [...]
  ]
}
```

Esri convention:
- exterior rings: clockwise;
- holes: counterclockwise.

Esri documents polygons returned by services as topologically simple.

Rings may touch/self-touch at a vertex under Esri rules, but other intersections are not valid simple polygon topology.

## Esri multipart polygons

Esri does not expose an `esriGeometryMultiPolygon` geometry type.

One Esri Polygon may contain:
- one outer shell;
- several holes;
- multiple disconnected outer shells;
- holes belonging to different shells.

When converting to OGC/GeoJSON, reconstruct Polygon vs MultiPolygon by topology and containment.

Do not rely solely on ring order.

## Envelope

Esri has a real Envelope geometry:

```json
{
  "xmin": 25.0,
  "ymin": 42.0,
  "xmax": 26.0,
  "ymax": 43.0,
  "spatialReference": { "wkid": 4326 }
}
```

GeoJSON has no Envelope geometry type.

Conversion policy:
- use an application bbox/extent when the semantic meaning is "search extent";
- convert to Polygon only when a real polygon geometry is required.

## hasZ and hasM

FeatureSet/geometry metadata may declare:
- `hasZ`;
- `hasM`.

Do not infer dimensional semantics from array length without checking the format/schema metadata.

## FeatureSet

ArcGIS FeatureSet can include:
- object ID field;
- global ID field;
- geometry type;
- spatial reference;
- `hasZ`;
- `hasM`;
- fields/schema;
- features.

Each feature commonly contains:
- `attributes`;
- `geometry`.

This is richer schema metadata than a normal GeoJSON FeatureCollection. Conversion to GeoJSON may therefore lose schema-level field metadata unless it is preserved separately.

## Tolerance and precision

Esri spatial references/geometry operations use tolerance/resolution concepts.

Do not translate Esri tolerance into arbitrary coordinate rounding.

Snapping/precision reduction is a topology-changing operation and must have an explicit policy.

## Projection

A change of spatial reference is a coordinate transformation, not a metadata rename.

Never convert:

```text
wkid 3857 -> 4326
```

by only replacing the ID.

## True curves

ArcGIS can represent curved geometries in contexts where plain GeoJSON cannot preserve those curves directly.

If curves enter OpenGeoForge:
- keep the original/source payload when required;
- define a densification/linearization tolerance;
- mark the conversion as lossy;
- test area/length deviation.

## Authoritative sources

- Geometry objects: https://developers.arcgis.com/rest/services-reference/enterprise/geometry-objects/
- FeatureSet: https://developers.arcgis.com/rest/services-reference/enterprise/featureset-object/
- Spatial references: https://developers.arcgis.com/documentation/spatial-references/
