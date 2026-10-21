Use the geometry-interoperability-specialist agent.

Review the requested geometry/data flow across GeoJSON, Esri JSON, PostGIS/NTS and OpenLayers.

Return:
- exact source/destination models;
- CRS/axis-order contract;
- geometry mapping table;
- polygon/ring/hole behavior;
- Z/M behavior;
- IDs/attributes/properties mapping;
- known lossy conversions;
- validation rules;
- OpenLayers read/write configuration;
- round-trip and invalid-geometry test cases.

Do not implement until ambiguous or lossy conversion behavior is explicitly documented.
