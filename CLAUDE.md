# OpenGeoForge — Claude Project Rules

OpenGeoForge is an open-source, production-oriented GIS platform.

## Non-negotiable architecture rules

1. PostGIS native geometry/geography is canonical storage.
2. RFC 7946 GeoJSON is the default public feature interchange.
3. GeoServer and GeoWebCache are private infrastructure.
4. Public edits go through .NET application slices, not unrestricted WFS-T.
5. GeoWebCache owns tile caching; Redis does not duplicate the tile store.
6. gRPC is only for justified internal .NET service boundaries.
7. Every geometry edit requires validation, audit and concurrency handling.
8. Every rendered-data mutation requires a cache invalidation decision.
9. Never silently repair geometry with ST_MakeValid/snap/simplify.
10. Use least-privilege database roles.
11. No unbounded BBOX, exports, image sizes, geometry vertices or feature results.
12. Keep implementation KISS/DRY/YAGNI.
13. Prefer Vertical Slice Architecture.
14. Avoid Helpers/Utils dumping grounds.
15. Keep unrelated models/types in separate files.
16. Do not describe a single-node deployment as HA.
17. GeoJSON, Esri JSON and OpenLayers are distinct models; never conflate them.
18. Esri Polygon rings require topology-aware shell/hole reconstruction when converting to OGC/GeoJSON.
19. Esri Envelope has no direct GeoJSON geometry type; preserve extent semantics unless Polygon is explicitly required.
20. M values are not a portable RFC 7946 contract; never silently drop them.
21. At OpenLayers API boundaries always distinguish dataProjection from featureProjection/view projection.
22. Every cross-format adapter must document CRS, dimensions and whether conversion is lossless or lossy.

## Source hierarchy

For GIS behavior prefer:
1. OGC specifications;
2. RFC 7946;
3. official PostGIS docs;
4. official GeoServer/GeoWebCache docs;
5. official Esri docs for ArcGIS interoperability;
6. official OpenLayers docs;
7. NetTopologySuite/Npgsql docs.

For any GeoJSON/Esri/OpenLayers work, also read:
- docs/standards/interoperability.md
- docs/standards/geojson.md
- docs/standards/esri-json.md
- docs/standards/crs-axis-order.md
- docs/frontend/openlayers.md

Verify current stable component versions before changing production pins.
