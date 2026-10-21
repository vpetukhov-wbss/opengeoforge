# OpenLayers Geometry and Projection Rules

OpenLayers is the recommended general-purpose browser GIS client for OpenGeoForge where broad OGC/vector editing support is useful.

## Important model rule

OpenLayers geometry coordinates live in the **feature/map projection used by the client**.

The default OpenLayers View projection is:

```text
EPSG:3857
```

The default `ol/format/GeoJSON` data projection is:

```text
EPSG:4326
```

Therefore raw GeoJSON coordinates must not simply be inserted into an EPSG:3857 view without transformation.

## Canonical GeoJSON read

```ts
import GeoJSON from 'ol/format/GeoJSON.js';

const format = new GeoJSON();

const features = format.readFeatures(payload, {
  dataProjection: 'EPSG:4326',
  featureProjection: map.getView().getProjection()
});
```

This converts API longitude/latitude data into the map projection.

## Canonical GeoJSON write

```ts
const geojson = format.writeFeatureObject(feature, {
  featureProjection: map.getView().getProjection(),
  dataProjection: 'EPSG:4326',
  rightHanded: true
});
```

This is the required pattern for editing APIs.

## Esri JSON

OpenLayers includes:

```ts
import EsriJSON from 'ol/format/EsriJSON.js';
```

Use it for ArcGIS REST/Esri JSON interoperability, not as a replacement for the standard public GeoJSON contract.

When reading Esri JSON:
- identify the Esri spatial reference;
- ensure OpenLayers knows the corresponding projection;
- explicitly provide/derive `dataProjection`;
- transform to the current view projection.

## View projection

OpenLayers View defaults to Web Mercator:

```ts
new View({
  projection: 'EPSG:3857'
});
```

All normal view coordinates/extents are interpreted in the view projection.

For longitude/latitude UI input, use projection transforms rather than assigning lon/lat directly as the EPSG:3857 center.

## Projection transforms

For common built-in projections use:
- `fromLonLat()`;
- `toLonLat()`;
- `transform()`;
- `transformExtent()`.

For additional/custom CRS, integrate proj4 and register the projection with OpenLayers.

Do not fetch arbitrary CRS definitions dynamically in security-sensitive/offline deployments without controlling the source and version of definitions.

## Polygon editing

Client drawing is provisional.

After the user draws/modifies:
1. OpenLayers may perform client UX checks;
2. serialize GeoJSON in EPSG:4326 with canonical winding;
3. send expected version/concurrency token;
4. server parses with NTS;
5. server validates type/SRID/topology/domain rules;
6. PostGIS constraints validate again;
7. save/audit/invalidate cache.

Never trust browser validation as the final geometry authority.

## Ring closure

OpenLayers can work with Polygon coordinate arrays, but the API boundary must still enforce the OpenGeoForge ring rules.

Do not assume "it rendered correctly" means "it is valid".

## Interaction rule

For editing:
- selected/highlighted geometry: vector feature;
- edit handles/sketch: vector layer;
- large reference layers: MVT/WMTS;
- final persisted edit: GeoJSON API.

Do not edit directly inside a cached raster tile.

## Esri services

If a client consumes an ArcGIS Feature Service:
- EsriJSON can be read explicitly;
- convert to OpenLayers geometry;
- do not mix its native CRS semantics with the OpenGeoForge RFC 7946 API contract.

## Authoritative sources

- OpenLayers API: https://openlayers.org/en/latest/apidoc/
- GeoJSON format: https://openlayers.org/en/latest/apidoc/module-ol_format_GeoJSON-GeoJSON.html
- EsriJSON format: https://openlayers.org/en/latest/apidoc/module-ol_format_EsriJSON-EsriJSON.html
- Projections: https://openlayers.org/en/latest/apidoc/module-ol_proj.html
- proj4 integration: https://openlayers.org/en/latest/apidoc/module-ol_proj_proj4.html
