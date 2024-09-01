module GeojsonFormatterService
  def self.format_geojson(shape)
    geojson = RGeo::GeoJSON.decode(shape, json_parser: :json)

    if geojson.is_a?(RGeo::GeoJSON::FeatureCollection)
      polygons = geojson.map(&:geometry).select { |geom| geom.geometry_type == RGeo::Feature::Polygon }
    
      RGeo::Geos.factory(srid: 4326).multi_polygon(polygons)
    else
      geojson
    end
  end
end