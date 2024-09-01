class FieldsController < ApplicationController
  before_action :set_field, only: %i[edit update]
  
  def index
    @fields = Field.all
  end

  def edit; end

  def update
    @field.update(field_params)
    geojson = RGeo::GeoJSON.decode(field_params[:shape], json_parser: :json)
    
    if geojson.is_a?(RGeo::GeoJSON::FeatureCollection)
      # Збираємо всі полігони з FeatureCollection
      polygons = []
    
      geojson.each do |feature|
        geom = feature.geometry
    
        if geom.geometry_type == RGeo::Feature::Polygon
          polygons << geom
        elsif geom.geometry_type == RGeo::Feature::MultiPolygon
          # Розгортаємо MultiPolygon у масив Polygon геометрій
          geom.each do |polygon|
            polygons << polygon
          end
        end
      end
    
      # Об'єднуємо їх у MultiPolygon
      factory = RGeo::Geos.factory(srid: 4326)
      multi_polygon = factory.multi_polygon(polygons)
    
      # Зберігаємо MultiPolygon у базі даних
      @field.shape = multi_polygon
    else
      # Якщо це не FeatureCollection, просто зберігаємо геометрію як є
      @field.shape = geojson
    end
    
    
    debugger

    @field.save
  end

  def new
    @field = Field.new
  end

  def create
    field = Field.new(field_params)

    if field.save
      redirect_to url_for(action: :edit, id: field.id), notice: "Field was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_field
    @field = Field.find(params[:id])
  end

  def field_params
    params.require(:field).permit(:name, :shape).tap do |param|
      param[:shape] = GeojsonFormatterService.format_geojson(param[:shape])
    end
  end
end
