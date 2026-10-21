# OpenGeoForge

**Open geospatial infrastructure for modern applications.**

[![License](https://img.shields.io/github/license/vpetukhov-wbss/opengeoforge)](LICENSE)
![Status](https://img.shields.io/badge/status-pre--1.0-orange)
![.NET](https://img.shields.io/badge/.NET-10-512BD4)
![PostGIS](https://img.shields.io/badge/PostGIS-spatial-336791)
![GeoServer](https://img.shields.io/badge/GeoServer-compatible-4BA74B)

OpenGeoForge is an open-source, production-oriented geospatial platform for storing, serving, rendering, querying and editing spatial data.

It is designed to give ordinary application teams a strong GIS backend without forcing every product team to build and operate its own mapping infrastructure.

## What OpenGeoForge is for

OpenGeoForge can support:

- utility networks, pipes, manholes, valves and cables;
- properties, parcels and administrative boundaries;
- roads, traffic, accidents and incidents;
- statistics, choropleths, heatmaps and dashboards;
- environmental and reference datasets;
- asset tracking and sensor data;
- personal and commercial mapping applications;
- Angular, Ionic, Blazor Hybrid and other web/mobile clients.

## Core stack

- .NET 10 Minimal APIs
- PostgreSQL + PostGIS
- GeoServer
- GeoWebCache
- Redis
- NetTopologySuite
- GeoJSON / RFC 7946
- Esri JSON / ArcGIS REST interoperability
- MVT
- WMS / WFS / WMTS
- OpenLayers / MapLibre
- Docker
- OpenTelemetry

## Architecture

```text
                         Internet
                            |
                           HTTPS
                            |
                    +-------v--------+
                    | GeoGateway.Api |
                    | .NET 10        |
                    +---+-----+------+
                        |     |
              HTTP/OGC  |     | Npgsql/NTS
                        |     |
                +-------v-+ +-v----------------+
                |GeoServer| | PostgreSQL/PostGIS|
                |   + GWC | +-------------------+
                +----+----+
                     |
                 tile cache

           Redis = application cache/coordination
           gRPC  = optional internal .NET boundaries
```

**GeoServer, PostgreSQL and Redis are private infrastructure.** Public applications communicate through the OpenGeoForge Gateway.

See [Architecture Overview](docs/architecture/overview.md).

## Design principles

1. **Open standards first**
2. **Production by default**
3. **PostGIS is the spatial source of truth**
4. **GeoJSON is the default application interchange**
5. **MVT/WMTS for scalable rendering**
6. **GeoServer stays private**
7. **Application edits go through validated APIs**
8. **Secure by default**
9. **Self-hostable and cloud portable**
10. **KISS, DRY and YAGNI**

See [Architecture Principles](docs/architecture/principles.md).

## Project status

OpenGeoForge is currently **pre-1.0 / early development**.

Public contracts may change until v1.0. The roadmap is intentionally incremental so the platform can be validated against real applications before stabilizing APIs.

See [ROADMAP.md](ROADMAP.md).

## Documentation

- [Architecture overview](docs/architecture/overview.md)
- [Architecture principles](docs/architecture/principles.md)
- [Geometry standards](docs/standards/geometry.md)
- [GeoJSON profile](docs/standards/geojson.md)
- [Esri JSON / ArcGIS geometry rules](docs/standards/esri-json.md)
- [Geometry interoperability model](docs/standards/interoperability.md)
- [CRS and axis-order rules](docs/standards/crs-axis-order.md)
- [OpenLayers integration rules](docs/frontend/openlayers.md)
- [API standards](docs/standards/api.md)
- [Production deployment](docs/deployment/production.md)
- [Production readiness](docs/operations/production-readiness.md)
- [Contributing](CONTRIBUTING.md)
- [Security policy](SECURITY.md)
- [Governance](GOVERNANCE.md)

## Open-source mission

> Make production-grade geospatial infrastructure accessible to application developers without requiring every team to become GIS infrastructure specialists.

## Contributing

Contributions, bug reports, design discussions and documentation improvements are welcome.

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## Security

Do not report vulnerabilities in public issues. Follow [SECURITY.md](SECURITY.md).

## License

Licensed under the [Apache License 2.0](LICENSE).
