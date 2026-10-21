# Mobile Storage and Security

## Storage selection

### SecureStore
Use for:
- refresh tokens;
- small cryptographic/device secrets;
- sensitive small configuration.

Do not use for:
- huge GeoJSON;
- offline map databases;
- large edit queues.

### SQLite
Use for:
- structured offline feature metadata;
- pending operation queue;
- bounded reference data;
- local indexes/queryable state.

### File system
Use for:
- large downloads;
- export files;
- bounded offline packages when licensing permits.

## Offline edit queue

Each mutation should carry:
- client operation ID;
- feature ID;
- expected version;
- operation type;
- payload;
- created timestamp;
- retry state.

Replay must be idempotent.

A 409 conflict is not a network retry. It requires conflict resolution.

## Secrets

Never:
- embed service credentials in the app bundle;
- embed GeoServer admin credentials;
- expose database/Redis credentials;
- log access/refresh tokens;
- store tokens in plain AsyncStorage.

## Environment separation

Native builds must have explicit API base URLs for:
- development;
- staging;
- production.

Do not infer production vs staging from a mutable runtime string supplied by untrusted content.

## Logs

Mobile logs/crash reports must not contain:
- auth tokens;
- full sensitive feature payloads;
- personally identifying property records;
- exact user position unless needed and allowed by telemetry policy.

## Offline map licensing

Before packaging third-party tiles/data for offline use, verify provider/database licensing and redistribution terms.

OpenStreetMap-derived data also carries attribution/license obligations.
