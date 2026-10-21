---
name: mobile-gis
description: Apply iOS/Android-specific GIS, location, offline, security and MapLibre rules.
---

# Mobile GIS Skill

Read:
- docs/frontend/ios.md
- docs/frontend/android.md
- docs/frontend/mobile-storage-security.md
- docs/frontend/map-engine-strategy.md

For every mobile feature report separately:

## iOS
- permission strings/config;
- When In Use vs Always;
- background modes;
- ATS/network implications;
- Keychain/SecureStore behavior;
- lifecycle/background behavior;
- physical-device tests.

## Android
- coarse/fine permissions;
- foreground service/background permission;
- network security/cleartext;
- Keystore/SecureStore behavior;
- process death/vendor restrictions;
- physical-device/API-level tests.

Never claim iOS and Android behavior is identical merely because the TypeScript API is shared.
