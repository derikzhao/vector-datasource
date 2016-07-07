UPDATE
  planet_osm_polygon
  SET mz_poi_min_zoom = mz_calculate_min_zoom_pois(planet_osm_polygon.*)
  WHERE
    (barrier = 'toll_booth' OR
     highway IN ('services', 'rest_area'))
    AND COALESCE(mz_poi_min_zoom, 999) <> COALESCE(mz_calculate_min_zoom_pois(planet_osm_polygon.*), 999);

UPDATE
  planet_osm_polygon
  SET mz_landuse_min_zoom = mz_calculate_min_zoom_landuse(planet_osm_polygon.*)
  WHERE
    highway IN  ('services', 'rest_area')
    AND COALESCE(mz_landuse_min_zoom, 999) <> COALESCE(mz_calculate_min_zoom_landuse(planet_osm_polygon.*), 999);

UPDATE
  planet_osm_polygon
  SET mz_building_min_zoom = mz_calculate_min_zoom_buildings(planet_osm_polygon.*)
  WHERE
    tags->'location' = 'underground'
    AND COALESCE(mz_building_min_zoom, 999) <> COALESCE(mz_calculate_min_zoom_buildings(planet_osm_polygon.*), 999);