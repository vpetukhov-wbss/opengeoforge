# CRS, Axis Order and Projection Rules

CRS mistakes are among the most dangerous GIS interoperability errors because the payload can remain syntactically valid while appearing in the wrong place.

## Internal rule

Every geometry crossing a system boundary must have a known source CRS.

Never guess CRS from coordinate magnitude unless performing diagnostics only.

## RFC 7946 GeoJSON

Public GeoJSON:
- WGS 84 geographic coordinates;
- longitude first, latitude second;
- no custom `crs` member.

## Esri JSON

Esri JSON can carry its own `spatialReference`:
- `wkid`;
- `latestWkid`;
- WKT;
- vertical CRS metadata.

Resolve legacy WKIDs deliberately.

Example:

```json
{
  "wkid": 102100,
  "latestWkid": 3857
}
```

represents the Web Mercator lineage; it is not WGS84 longitude/latitude.

## OpenLayers

Default View:
```text
EPSG:3857
```

Default GeoJSON dataProjection:
```text
EPSG:4326
```

Always distinguish:
- data projection;
- feature projection;
- map view projection.

## WMS/WFS warning

Do not generalize a single axis-order rule across all OGC protocol versions.

The exact axis semantics can depend on:
- protocol;
- protocol version;
- CRS identifier representation.

GeoServer adapters/tests must cover the exact WMS/WFS versions we expose.

## ST_SetSRID vs ST_Transform

`ST_SetSRID` assigns/declares metadata.

`ST_Transform` changes coordinate values.

Using `ST_SetSRID` to "convert" 3857 coordinates to 4326 is a data corruption bug.

## Distance/area

Do not calculate metric distance/area from EPSG:4326 degrees as if they were meters.

Use:
- an appropriate projected CRS; or
- PostGIS geography where its semantics suit the use case.

## Z

Track:
- horizontal CRS;
- vertical CRS if present;
- Z unit;
- Z meaning (elevation/depth/etc.).

A Z number without these semantics is not enough for engineering-quality utility data.
