class FieldsController < ApplicationController
  include Pagy::Backend

  before_action :set_field, only: %i[edit update]
  
  def index
    @fields = Field.ransack(params[:q]).result

    unless params.dig(:disable_pagy)
      @pagy, @fields = pagy(@fields)
    end
  end

  def edit; end

  def update
    @field = Field.new(field_params)
    if @field.save
      redirect_to edit_field_path(@field), notice: "Field was successfully edited"
    else
      flash.now[:error] = @field.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @field = Field.new
  end

  def create
    @field = Field.new(field_params)
    if @field.save
      redirect_to edit_field_path(@field), notice: "Field was successfully created"
    else
      flash.now[:error] = @field.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_field
    @field = Field.find(params[:id])
  end

  def field_params
    params.require(:field).permit(:name, :shape).tap do |param|
      param[:shape] = GeoDataService.format_geojson(param[:shape])
    end
  end
end
