module GeoDataService
  class << self
    def format_geojson(shape)
      geojson = RGeo::GeoJSON.decode(shape, json_parser: :json)
    
      if geojson.is_a?(RGeo::GeoJSON::FeatureCollection)
        polygons = []
      
        geojson.each do |feature|
          geom = feature.geometry
      
          if geom.geometry_type == RGeo::Feature::Polygon
            polygons << geom
          elsif geom.geometry_type == RGeo::Feature::MultiPolygon
            geom.each do |polygon|
              polygons << polygon
            end
          end
        end

        factory = RGeo::Geos.factory(srid: 4326)
        multi_polygon = factory.multi_polygon(polygons)
      
        multi_polygon
      else
        geojson
      end
    end

    def calculate_shape_area(shape)
      first_point = shape.geometry_n(0).exterior_ring.point_n(0)
      longitude = first_point.x
      latitude = first_point.y

      srid = find_utm_srid(longitude, latitude)
      utm_zone = find_utm_zone(longitude)

      utm_factory = RGeo::Geographic.projected_factory(
        projection_proj4: "+proj=utm +zone=#{utm_zone} +datum=WGS84",
        srid: 4326,
        projection_srid: srid
      )

      projected_shape = RGeo::Feature.cast(shape, factory: utm_factory)

      projected_shape.area
    end

    private

    def find_utm_zone(longitude)
      (longitude / 6).floor + 31
    end

    def find_utm_srid(longitude, latitude)
      zone = find_utm_zone(longitude)
      hemisphere = latitude >= 0 ? 32600 : 32700
      hemisphere + zone
    end
  end
end