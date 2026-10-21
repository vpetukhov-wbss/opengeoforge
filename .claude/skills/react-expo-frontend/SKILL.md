---
name: react-expo-frontend
description: Implement/review OpenGeoForge React + Expo + TypeScript apps across Web, iOS and Android.
---

# React + Expo Frontend Skill

## Required decisions first

Identify:
- target platforms;
- whether this is headless backend only or includes a client;
- web map engine: OpenLayers default, Leaflet if justified;
- native map engine: MapLibre React Native default;
- location/background/offline requirements;
- authentication method.

## Implementation order

1. strict TypeScript/Expo shell;
2. environment/API configuration;
3. generated OpenAPI client boundary;
4. shared feature model;
5. `GeoMap.web.tsx`;
6. `GeoMap.native.tsx`;
7. iOS/Android permissions and build config;
8. GeoJSON projection adapters;
9. identify/selection;
10. editing/concurrency;
11. offline queue if required;
12. web/native tests.

Reject code that:
- imports ol/Leaflet into native;
- relies on Expo Go with MapLibre native code;
- creates maps during render;
- omits map/listener cleanup;
- sends EPSG:3857 as RFC 7946 coordinates;
- stores tokens in AsyncStorage;
- requests Always/background location without a requirement;
- enables broad HTTP cleartext in production;
- duplicates backend DTOs casually;
- accesses private GeoServer endpoints.
