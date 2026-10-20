# Production Readiness Checklist

A release is not production-ready if any required gate fails.

## Security
- [ ] GeoServer admin/REST is private.
- [ ] PostgreSQL and Redis are private.
- [ ] No default credentials.
- [ ] Secrets are not committed.
- [ ] Render DB user is read-only where possible.
- [ ] Public filters are validated/allowlisted.
- [ ] Rate/resource limits exist.

## Data
- [ ] Geometry type/SRID constraints exist.
- [ ] Required spatial indexes exist.
- [ ] Backups are current.
- [ ] Restore has been tested.
- [ ] Destructive migrations have rollback/approval.

## Rendering
- [ ] GeoServer and extensions use compatible versions.
- [ ] Representative WMS/WMTS/MVT tests pass.
- [ ] GeoWebCache quota is enabled.
- [ ] Cache invalidation behavior is tested.

## Application
- [ ] AuthN/AuthZ tests pass.
- [ ] GeoJSON contract tests pass.
- [ ] Optimistic concurrency is tested.
- [ ] Audit records are created for edits.
- [ ] Unbounded requests are rejected.

## Operations
- [ ] Health endpoints work.
- [ ] Metrics/logs/traces are available.
- [ ] Disk/DB/5xx/latency/backup alerts exist.
- [ ] Rollback procedure is documented.
