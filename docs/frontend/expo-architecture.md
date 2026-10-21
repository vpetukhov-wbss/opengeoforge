# Expo Architecture

## Supported targets

OpenGeoForge reference client may target:
- web;
- iOS;
- Android.

The backend does not depend on the reference client.

## Platform separation

Use platform-specific modules rather than runtime hacks:

```text
GeoMap.web.tsx
GeoMap.native.tsx
```

When iOS and Android require different behavior:

```text
LocationPolicy.ios.ts
LocationPolicy.android.ts
```

Expo/React Native resolves platform files automatically.

## Map engines

Default:

```text
Web       -> OpenLayers
iOS       -> MapLibre React Native
Android   -> MapLibre React Native
```

Optional:
- Leaflet for simpler web-only maps;
- another native engine only through an ADR.

OpenLayers and Leaflet are browser/DOM libraries. They must not be imported into native bundles.

Do not wrap them in a WebView for native merely to share code. A WebView map requires an explicit ADR covering offline behavior, performance, accessibility, native gestures, bridge complexity and security.

## Development builds

The native reference app is a production-grade Expo app and uses development builds, not Expo Go, once native map modules are installed.

MapLibre React Native requires native code/configuration and therefore a development build.

When native dependencies or app config change:
- regenerate native projects as appropriate;
- rebuild the development client.

JS/TS-only changes do not require rebuilding the native binary.

## Suggested structure

```text
apps/expo/
  app/                         Expo Router routes
  src/
    features/
    components/
    map/
      GeoMap.tsx
      GeoMap.web.tsx
      GeoMap.native.tsx
      openlayers/
      maplibre/
    infrastructure/
      api/
      auth/
      storage/
      telemetry/
    generated/
```

Do not put unrelated business logic in route files.
