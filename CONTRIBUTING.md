# Contributing to OpenGeoForge

Thank you for contributing.

## Before you start

For substantial changes, open an issue or discussion first so the design can be aligned before implementation.

## Development principles

- prefer simple, explicit code;
- use Vertical Slice Architecture for application features;
- avoid catch-all Helpers/Utils folders;
- keep unrelated models in separate files;
- PostGIS geometry is canonical storage;
- GeoJSON is the default public geometry interchange;
- keep GeoServer private;
- never silently repair user geometry;
- consider cache invalidation for every rendered-data change;
- add tests for behavior, geometry edge cases and security boundaries.

## Branches

Use short-lived branches:

- `feature/<name>`
- `fix/<name>`
- `docs/<name>`
- `chore/<name>`

`main` should remain releasable.

## Commit messages

Use clear imperative messages, for example:

- `feat: add geometry validation endpoint`
- `fix: reject unbounded bbox requests`
- `docs: describe GeoWebCache invalidation`

## Pull requests

A pull request should explain:

- what changed;
- why it changed;
- tests performed;
- security/performance implications;
- migration or rollback requirements;
- documentation impact.

## Tests

Changes should include the narrowest useful tests:

- unit tests for domain behavior;
- integration tests for PostGIS/GeoServer contracts;
- geometry validity fixtures;
- architecture tests where dependency rules matter;
- performance tests for hot spatial paths.

## License

By contributing, you agree that your contributions are licensed under Apache-2.0.
