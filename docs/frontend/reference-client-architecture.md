# Reference Client Architecture

The OpenGeoForge reference frontend demonstrates correct platform consumption without coupling the backend to React/Expo.

## Structure

```text
apps/expo/
  app/                         Expo Router routes
  src/
    features/
      layers/
      identify/
      search/
      editing/
      statistics/
    components/
    map/
      GeoMap.tsx
      GeoMap.web.tsx
      GeoMap.native.tsx
      types.ts
      openlayers/
      maplibre/
    infrastructure/
      api/
      auth/
      storage/
      telemetry/
    generated/
```

## Dependency direction

```text
routes/screens
    |
    v
features
    |
    +--> typed API client
    +--> narrow map abstraction
              |
              +--> OpenLayers web adapter
              +--> MapLibre native adapter
```

Feature code should not import raw map-engine instances unless that feature is intentionally engine-specific.

## Vertical feature organization

Example:

```text
features/editing/
  components/
    FeatureEditor.tsx
  hooks/
    useFeatureEdit.ts
  model/
    edit-session.ts
  api/
    update-feature.ts
```

Avoid generic `helpers.ts` / `utils.ts` dumping grounds.

## Transport vs UI models

Generated OpenAPI transport types live in `generated/` or the API infrastructure boundary.

Create UI/domain models only when semantics differ.

Do not manually copy every backend DTO into a second interface tree.

## Map state

Share only application concepts:
- viewport;
- selected feature ID;
- visible layer IDs;
- edit session;
- identify result.

Do not globally store the entire OpenLayers/MapLibre object graph.

## Errors

Provide distinct UX for:
- offline/network failure;
- 401 unauthenticated;
- 403 unauthorized;
- 409 edit conflict;
- 422 geometry/domain validation;
- 429 rate limit;
- long-running import/export failure.

Do not collapse all failures into a generic toast.

## Backend independence

The backend must work with:
- this reference client;
- a custom React client;
- Angular;
- native apps;
- desktop GIS;
- server-to-server clients.

The reference client is never a privileged transport.
