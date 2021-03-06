DO $$
BEGIN

--------------------------------------------------------------------------------
-- planet_osm_line
--------------------------------------------------------------------------------

UPDATE planet_osm_line
  SET mz_road_level = mz_calculate_min_zoom_roads(planet_osm_line.*)
  WHERE mz_calculate_min_zoom_roads(planet_osm_line.*) IS NOT NULL;

UPDATE planet_osm_line
  SET mz_transit_level = mz_calculate_min_zoom_transit(planet_osm_line.*)
  WHERE mz_calculate_min_zoom_transit(planet_osm_line.*) IS NOT NULL;

UPDATE planet_osm_line
  SET mz_earth_min_zoom = mz_calculate_min_zoom_earth(planet_osm_line.*)
  WHERE mz_calculate_min_zoom_earth(planet_osm_line.*) IS NOT NULL;

UPDATE planet_osm_line
  SET mz_water_min_zoom = mz_calculate_min_zoom_water(planet_osm_line.*)
  WHERE mz_calculate_min_zoom_water(planet_osm_line.*) IS NOT NULL;

UPDATE planet_osm_line
  SET mz_boundary_min_zoom = mz_calculate_min_zoom_boundaries(planet_osm_line.*)
  WHERE mz_calculate_min_zoom_boundaries(planet_osm_line.*) IS NOT NULL;

UPDATE planet_osm_line
  SET mz_landuse_min_zoom = mz_calculate_min_zoom_landuse(planet_osm_line.*)
  WHERE mz_calculate_min_zoom_landuse(planet_osm_line.*) IS NOT NULL;

UPDATE planet_osm_line
  SET mz_label_placement = ST_PointOnSurface(way);

CREATE INDEX planet_osm_line_roads_geom_index ON planet_osm_line USING gist(way) WHERE mz_road_level IS NOT NULL;
CREATE INDEX planet_osm_line_roads_geom_9_index ON planet_osm_line USING gist(way) WHERE mz_road_level <= 9;
CREATE INDEX planet_osm_line_roads_geom_12_index ON planet_osm_line USING gist(way) WHERE mz_road_level <= 12;
CREATE INDEX planet_osm_line_roads_geom_15_index ON planet_osm_line USING gist(way) WHERE mz_road_level <= 15;

CREATE INDEX planet_osm_line_transit_geom_index ON planet_osm_line USING gist(way) WHERE mz_transit_level IS NOT NULL;
CREATE INDEX planet_osm_line_transit_geom_6_index ON planet_osm_line USING gist(way) WHERE mz_transit_level <= 6;
CREATE INDEX planet_osm_line_transit_geom_9_index ON planet_osm_line USING gist(way) WHERE mz_transit_level <= 9;
CREATE INDEX planet_osm_line_transit_geom_12_index ON planet_osm_line USING gist(way) WHERE mz_transit_level <= 12;
CREATE INDEX planet_osm_line_transit_geom_15_index ON planet_osm_line USING gist(way) WHERE mz_transit_level <= 15;

CREATE INDEX planet_osm_line_earth_geom_index ON planet_osm_line USING gist(way) WHERE mz_earth_min_zoom IS NOT NULL;
CREATE INDEX planet_osm_line_earth_geom_9_index ON planet_osm_line USING gist(way) WHERE mz_earth_min_zoom <= 9;
CREATE INDEX planet_osm_line_earth_geom_12_index ON planet_osm_line USING gist(way) WHERE mz_earth_min_zoom <= 12;
CREATE INDEX planet_osm_line_earth_geom_15_index ON planet_osm_line USING gist(way) WHERE mz_earth_min_zoom <= 15;

CREATE INDEX planet_osm_line_water_geom_index ON planet_osm_line USING gist(way) WHERE mz_water_min_zoom IS NOT NULL;
CREATE INDEX planet_osm_line_water_geom_9_index ON planet_osm_line USING gist(way) WHERE mz_water_min_zoom <= 9;
CREATE INDEX planet_osm_line_water_geom_12_index ON planet_osm_line USING gist(way) WHERE mz_water_min_zoom <= 12;
CREATE INDEX planet_osm_line_water_geom_15_index ON planet_osm_line USING gist(way) WHERE mz_water_min_zoom <= 15;

CREATE INDEX planet_osm_line_boundary_geom_index ON planet_osm_line USING gist(way) WHERE mz_boundary_min_zoom IS NOT NULL;
CREATE INDEX planet_osm_line_boundary_geom_9_index ON planet_osm_line USING gist(way) WHERE mz_boundary_min_zoom <= 9;
CREATE INDEX planet_osm_line_boundary_geom_12_index ON planet_osm_line USING gist(way) WHERE mz_boundary_min_zoom <= 12;
CREATE INDEX planet_osm_line_boundary_geom_15_index ON planet_osm_line USING gist(way) WHERE mz_boundary_min_zoom <= 15;

END $$;

ANALYZE planet_osm_line;
