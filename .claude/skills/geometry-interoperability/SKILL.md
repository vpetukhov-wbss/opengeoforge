---
name: geometry-interoperability
description: Convert and review GeoJSON, Esri JSON and OpenLayers geometry safely.
---

# Geometry Interoperability Skill

Read the geometry/interoperability standards before implementation.

## Required workflow

1. Identify source format exactly.
2. Identify source CRS exactly.
3. Identify source geometry type and dimensionality.
4. Parse without destructive normalization.
5. Convert to NTS/PostGIS canonical geometry.
6. Validate structure and topology.
7. Apply explicit CRS transformation if required.
8. Convert to destination model.
9. Normalize destination-specific winding/shape rules.
10. Validate again.
11. Report any lost metadata or dimensions.
12. Add round-trip fixtures where the conversion is intended to be lossless.

## Special cases

### Esri Polygon -> GeoJSON
Reconstruct shell/hole topology and Polygon/MultiPolygon structure. Do not array-copy rings.

### Esri Envelope -> GeoJSON
Prefer bbox/extent semantics. Convert to Polygon only if polygon semantics are required.

### Esri M -> GeoJSON
Treat as lossy unless a separate documented contract preserves M.

### OpenLayers -> API
Write with explicit `featureProjection`, `dataProjection: 'EPSG:4326'` and `rightHanded: true`.

### API -> OpenLayers
Read with explicit `dataProjection: 'EPSG:4326'` and map `featureProjection`.
