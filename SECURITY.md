# Security Policy

## Reporting a vulnerability

Please do **not** open a public issue for a suspected vulnerability.

Use GitHub's private **Report a vulnerability** / Security Advisory flow for this repository.

Include, when possible:

- affected version/commit;
- component;
- reproduction steps;
- impact;
- proof of concept;
- suggested mitigation.

## Security posture

OpenGeoForge treats these components as private infrastructure:

- GeoServer administration and REST configuration API;
- PostgreSQL/PostGIS;
- Redis;
- GeoWebCache administrative endpoints.

The public boundary is the .NET Gateway.

## Supported versions

Until v1.0, security fixes are applied to the latest development line only. A formal support matrix will be published before the first stable release.

## Disclosure

Please allow maintainers reasonable time to investigate and release a fix before public disclosure.
