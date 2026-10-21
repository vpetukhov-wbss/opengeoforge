# iOS GIS / Expo Rules

These rules are iOS-specific and are mandatory for OpenGeoForge reference clients.

## Native map runtime

Default native map engine:
- MapLibre React Native.

It requires native integration and a development/native build; it is not an Expo Go dependency.

Use the Expo config plugin so native installation is reproducible.

Do not manually patch generated iOS files when a supported config-plugin option exists, unless the repository intentionally owns native projects and the reason is documented.

## Bundle identity

Production/development variants need deliberate bundle identifiers.

Do not reuse a production bundle identifier casually for local experiments that change entitlements, permissions or backend environments.

## Location permission model

iOS distinguishes:
- **When In Use**;
- **Always**.

OpenGeoForge rule:
1. request foreground/When In Use only when a feature needs it;
2. request background/Always only for a user-visible feature that truly requires it;
3. explain the purpose in human language;
4. remain functional with reduced permission where possible.

Do not request Always/background location at first launch just because the app may need it later.

With Expo Location, configure purpose strings/config plugin settings for:
- `NSLocationWhenInUseUsageDescription`;
- `NSLocationAlwaysAndWhenInUseUsageDescription` when background location is actually enabled.

If background location is enabled, iOS also requires the location background mode.

Background-location code/tasks must follow Expo's TaskManager/background rules and be tested in a development build.

## Allow Once caveat

iOS can grant foreground location as "Allow Once".

Do not assume a foreground grant means durable permission.

The app must tolerate later background permission denial and should direct the user to Settings only when necessary.

## Geofencing

iOS has platform limits for monitored regions.

Do not design a feature that assumes unlimited geofences. Keep an application-level scheduling strategy for the nearest/relevant regions.

## HTTPS / ATS

Production OpenGeoForge mobile traffic must use HTTPS.

Apple App Transport Security (ATS) requires secure networking for normal URL loading.

Do not ship a broad ATS exception such as globally allowing insecure HTTP.

If local development needs an exception, scope it narrowly and make sure production configuration removes it.

## Secure tokens

Store refresh/access material that needs device persistence using a secure native mechanism such as Expo SecureStore/Keychain-backed storage.

Do not store tokens in ordinary AsyncStorage as if it were secret storage.

Do not use SecureStore as the only source of truth for irreplaceable domain data.

## Keychain behavior

iOS Keychain-backed values can behave differently from Android app storage across uninstall/reinstall.

Do not build security assumptions around "uninstall always deletes credentials".

Explicit logout must remove the application's token material.

## App lifecycle

Assume the app can:
- move foreground/background frequently;
- be suspended;
- be terminated by the OS/user.

Do not keep unsaved geometry edits only in volatile component state if loss would be harmful.

For long edit sessions, persist a local draft explicitly.

## Background location

Background tracking is battery-sensitive and privacy-sensitive.

Use:
- minimum acceptable accuracy;
- appropriate distance/time intervals;
- deferred updates where supported and suitable.

Do not request high-frequency GPS indefinitely by default.

## iOS testing matrix

At minimum test:
- real iPhone, not simulator only;
- location denied;
- location Allow Once;
- When In Use;
- Always/background if used;
- app background/foreground;
- process termination/relaunch;
- network offline/recovery;
- large MVT map;
- geometry edit conflict;
- secure token logout/relogin.

## Sources

- Expo permissions: https://docs.expo.dev/guides/permissions/
- Expo Location: https://docs.expo.dev/versions/latest/sdk/location/
- MapLibre Expo setup: https://maplibre.org/maplibre-react-native/docs/setup/expo/
- Apple ATS: https://developer.apple.com/documentation/BundleResources/Information-Property-List/NSAppTransportSecurity
