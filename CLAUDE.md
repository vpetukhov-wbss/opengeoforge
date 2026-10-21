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
23. React/Expo frontend code uses strict TypeScript and correct React hook/effect rules.
24. OpenLayers and Leaflet are web/DOM-only in the default architecture.
25. Expo iOS/Android use a native map adapter; default is MapLibre React Native.
26. Native map code requires development/native builds where native modules are used; never assume Expo Go.
27. Use platform-specific .web/.native/.ios/.android modules instead of bundling unsupported engines.
28. Do not wrap OpenLayers/Leaflet in a WebView for native without an approved ADR.
29. iOS and Android permission/background/process behavior must be documented separately.
30. Background location requires an explicit product requirement and minimum necessary permission/accuracy.
31. Production mobile networking uses HTTPS; broad ATS/Android cleartext exceptions are forbidden.
32. Sensitive mobile tokens belong in secure native storage, not plain AsyncStorage.
33. Important offline edits require a durable idempotent queue and explicit 409 conflict handling.
34. The OpenGeoForge backend must remain fully usable without the reference React/Expo frontend.
35. Public backend contracts are documented in OpenAPI; generated TypeScript contracts are preferred over duplicate DTOs.

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

## React / Expo / mobile mandatory references

For frontend, Expo, iOS, Android or headless API work read the relevant files before coding:

- docs/frontend/react-expo-typescript.md
- docs/frontend/expo-architecture.md
- docs/frontend/map-engine-strategy.md
- docs/frontend/reference-client-architecture.md
- docs/frontend/openlayers.md
- docs/frontend/ios.md
- docs/frontend/android.md
- docs/frontend/mobile-storage-security.md
- docs/api/headless-backend-service.md

Use the react-expo-frontend-specialist for frontend/mobile implementation and headless-api-specialist for public backend-only contracts.
