FactoryBot.define do
  factory :field do
    name { 'field' }
    
    shape do
      factory = RGeo::Geographic.spherical_factory(srid: 4326)
    
      center_lon = -122.0
      center_lat = 47.0
      radius = 0.5
    
      angles = (0...4).map { rand(0.0..360.0) }.sort
    
      points = angles.map do |angle|
        angle_rad = angle * Math::PI / 180.0
        lon = center_lon + radius * Math.cos(angle_rad)
        lat = center_lat + radius * Math.sin(angle_rad)
        factory.point(lon, lat)
      end
    
      points << points.first
    
      factory.multi_polygon(
        [
          factory.polygon(
            factory.linear_ring(points)
          )
        ]
      )
    end
  end
end