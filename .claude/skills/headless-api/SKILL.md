---
name: headless-api
description: Build OpenGeoForge as a stable backend-only geospatial service.
---

# Headless API Skill

Read docs/api/headless-backend-service.md and API/geometry standards.

For each public endpoint define:
1. method/path;
2. authorization;
3. media types;
4. typed schema;
5. geometry/CRS semantics;
6. limits;
7. errors;
8. caching;
9. concurrency for writes;
10. OpenAPI representation;
11. security tests.

The reference React/Expo client is just one consumer and must never be required.
