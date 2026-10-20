#!/usr/bin/env bash
set -euo pipefail

REPO="${1:-vpetukhov-wbss/opengeoforge}"

gh repo edit "$REPO" \
  --description "Open-source geospatial platform for serving, rendering, querying and editing spatial data with .NET, PostGIS, GeoServer, GeoWebCache, Redis, GeoJSON and vector tiles." \
  --enable-issues \
  --enable-discussions \
  --enable-projects

topics=(
  gis geospatial geoserver postgis postgresql geojson vector-tiles mvt
  wmts wms wfs ogc dotnet dotnet10 redis maplibre openlayers docker
  self-hosted open-source spatial-data
)

for topic in "${topics[@]}"; do
  gh repo edit "$REPO" --add-topic "$topic"
done
