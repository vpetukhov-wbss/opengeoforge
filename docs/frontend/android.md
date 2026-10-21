# Android GIS / Expo Rules

These rules are Android-specific and mandatory for OpenGeoForge reference clients.

## Native map runtime

Default:
- MapLibre React Native.

Use an Expo development/native build; do not rely on Expo Go for the native map module.

The current MapLibre React Native line has native Android requirements. Verify current minimum SDK/API and React Native compatibility before changing project pins.

## Application ID

Keep production, staging and development application IDs/environment configuration deliberate.

Do not accidentally point a debug build at production write endpoints.

## Location permissions

Android location can involve:
- approximate/coarse location;
- precise/fine location;
- foreground-service location;
- background location.

Rules:
1. request only permissions required by the active feature;
2. support approximate location where the feature can work with it;
3. do not request background location unless the user-facing requirement is explicit;
4. handle permanent denial and Settings flows;
5. never assume permission state is identical across Android versions/devices.

Expo Location adds coarse/fine foreground permissions and can configure background/foreground-service permissions when enabled.

## Foreground service

If continuous location must continue while the app is backgrounded, Android may require a foreground service and visible notification.

Android 14+ has additional foreground-service location permission requirements.

Treat this as a product/privacy feature, not an implementation detail.

## Background location

Background location has OS and store-policy implications.

A production feature must document:
- why background access is necessary;
- user-facing value;
- frequency/accuracy;
- battery impact;
- data retention;
- Play review requirements.

A killed app is not guaranteed to restart for location/geofence events. Device vendors also vary in background process behavior.

Never design correctness around a guarantee that Android will keep the JS/runtime process alive.

## Geofencing

Android allows a bounded number of active geofences.

Use a rotating/relevant-set strategy rather than assuming unlimited regions.

## Network security

Production APIs/tiles must use HTTPS.

Modern Android versions disable cleartext traffic by default for normal app configurations.

Do not globally enable cleartext traffic for production.

If local development requires HTTP:
- use a debug-only or domain-specific network security exception;
- never broaden production trust/cleartext configuration.

## Secure tokens

Use Expo SecureStore or equivalent Android Keystore-backed secure storage for sensitive small values such as tokens.

Do not store tokens in ordinary AsyncStorage.

SecureStore data is not a durable domain database and is not preserved like canonical server state.

## Offline/domain data

For structured offline caches/edit queues use a deliberate local store such as SQLite.

Separate:
- secure secrets -> SecureStore;
- structured offline/cache/edit queue -> SQLite/local DB;
- large offline files/tiles -> filesystem/tile-specific storage.

Do not put all three categories into one key-value store.

## App/process lifecycle

Android can stop background processes aggressively.

Persist important pending edits/operation IDs before depending on later replay.

Workers/background tasks must be idempotent because retries/restarts can happen.

## Performance

Test real low/mid-range Android hardware.

Watch:
- memory pressure;
- vector tile/style complexity;
- number of symbols/labels;
- GeoJSON feature counts;
- location update rate;
- offline cache size.

Do not accept performance based only on a desktop browser or high-end emulator.

## Android testing matrix

At minimum:
- real Android device;
- API levels representative of supported range;
- approximate location;
- precise location;
- denied/permanently denied permission;
- background location if used;
- battery saver/background restrictions;
- app killed/restarted;
- offline/reconnect;
- large MVT map;
- edit queue replay/conflict.

## Sources

- Expo permissions: https://docs.expo.dev/guides/permissions/
- Expo Location: https://docs.expo.dev/versions/latest/sdk/location/
- Android network security: https://developer.android.com/privacy-and-security/security-config
- MapLibre Expo setup: https://maplibre.org/maplibre-react-native/docs/setup/expo/
