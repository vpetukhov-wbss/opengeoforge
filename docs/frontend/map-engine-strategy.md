# Map Engine Strategy

## Default choices

| Runtime | Default | Alternative |
|---|---|---|
| Expo Web / React Web | OpenLayers | Leaflet |
| Expo iOS | MapLibre React Native | ADR-required native adapter |
| Expo Android | MapLibre React Native | ADR-required native adapter |
| Backend-only client | none | consumer chooses |

## OpenLayers

Use for GIS-heavy web applications:
- WMS/WMTS;
- MVT;
- GeoJSON;
- EsriJSON;
- multiple projections;
- drawing/editing;
- feature identify;
- complex layers.

React lifecycle:
- create map after DOM target exists;
- hold `ol/Map` in a ref;
- do not recreate per render;
- unregister listeners;
- detach target on cleanup.

GeoJSON API data is EPSG:4326 lon/lat; OpenLayers view is usually EPSG:3857. Read/write with explicit dataProjection/featureProjection.

## Leaflet

Use for simpler web-only mapping:
- markers;
- raster/tile maps;
- modest GeoJSON;
- straightforward interactions.

Leaflet is also DOM/browser-based and not the native Expo iOS/Android engine.

Prefer OpenLayers where advanced CRS/OGC/editing behavior is important unless the Leaflet plugin stack has been explicitly selected and tested.

## MapLibre React Native

Use on iOS/Android for native vector/raster mapping.

It wraps MapLibre Native and supports native mobile maps.

For Expo:
- install the MapLibre package using Expo-compatible dependency installation;
- add its config plugin;
- build a development client/native binary;
- do not expect Expo Go to load it.

Keep native implementation behind `.native.tsx`.

## Shared abstraction

Share application capabilities, not raw map-engine APIs.

Good shared concepts:
- viewport;
- selected feature;
- map layer descriptor;
- identify request/result;
- edit session;
- fit bounds;
- visibility.

Do not leak `ol/Map`, Leaflet `L.Map`, or MapLibre native instances across unrelated features.

## Rendering choices

```text
stable basemap          -> WMTS
large interactive data -> MVT
small/dynamic overlay   -> GeoJSON
server-styled image     -> WMS
edit sketch             -> native/web vector layer -> GeoJSON API
```
