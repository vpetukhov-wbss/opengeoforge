#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-vpetukhov-wbss/opengeoforge}"

create_or_update () {
  local name="$1" color="$2" description="$3"
  gh label create "$name" --repo "$REPO" --color "$color" --description "$description" --force
}

create_or_update "bug" "d73a4a" "Something is not working"
create_or_update "feature" "1f6feb" "New capability or improvement"
create_or_update "documentation" "0075ca" "Documentation improvements"
create_or_update "security" "b60205" "Security-related work"
create_or_update "performance" "fbca04" "Performance and scalability"
create_or_update "area:geoserver" "4ba74b" "GeoServer"
create_or_update "area:postgis" "336791" "PostgreSQL/PostGIS"
create_or_update "area:gateway" "512bd4" ".NET Gateway"
create_or_update "area:geometry" "8a2be2" "Geometry rules and validation"
create_or_update "area:tiles" "0e8a16" "MVT/WMTS/rendering"
create_or_update "area:caching" "5319e7" "GeoWebCache/Redis caching"
create_or_update "area:import" "bfdadc" "Spatial imports/reference data"
create_or_update "area:frontend" "2ea44f" "Client mapping integration"
create_or_update "area:devops" "6f42c1" "Deployment/operations"
create_or_update "good first issue" "7057ff" "Good entry point for new contributors"
create_or_update "help wanted" "008672" "Extra attention is welcome"
create_or_update "breaking-change" "b60205" "Changes a public contract"
