FactoryBot.define do
  factory :field do
    name { 'field' }
    
    shape do
      RGeo::Geographic.spherical_factory(srid: 4326).multi_polygon(
        [
          RGeo::Geographic.spherical_factory(srid: 4326).polygon(
            RGeo::Geographic.spherical_factory(srid: 4326).linear_ring([
              RGeo::Geographic.spherical_factory(srid: 4326).point(-122.0, 47.0),
              RGeo::Geographic.spherical_factory(srid: 4326).point(-122.1, 47.0),
              RGeo::Geographic.spherical_factory(srid: 4326).point(-122.1, 47.1),
              RGeo::Geographic.spherical_factory(srid: 4326).point(-122.0, 47.1),
              RGeo::Geographic.spherical_factory(srid: 4326).point(-122.0, 47.0)
            ])
          )
        ]
      )
    end
  end
end