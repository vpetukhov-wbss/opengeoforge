---
name: geoserver-production-platform
description: Build, review and operate OpenGeoForge as a production GIS platform.
---

# OpenGeoForge Production Platform

Before implementation read:
- CLAUDE.md
- docs/architecture/overview.md
- docs/architecture/principles.md
- docs/standards/geometry.md
- docs/standards/api.md
- docs/deployment/production.md
- docs/operations/production-readiness.md

Workflow:
1. inventory host/repository;
2. verify stable compatible versions;
3. design private network boundaries;
4. establish PostGIS role/schema model;
5. provision GeoServer idempotently;
6. configure GeoWebCache quotas;
7. implement Gateway contracts;
8. add observability;
9. prove backup restore;
10. run security/render/edit/geometry tests.
