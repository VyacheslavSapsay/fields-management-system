# frozen_string_literal: true

class FieldsController < ApplicationController
  include Pagy::Backend

  before_action :set_field, only: %i[edit update]

  def index
    @fields = Field.ransack(params[:q]).result

    return if params[:disable_pagy]

    @pagy, @fields = pagy(@fields)
  end

  def new
    @field = Field.new
  end

  def edit; end

  def create
    @field = Field.new(field_params)
    if @field.save
      redirect_to edit_field_path(@field), notice: I18n.t('fields.successful_created')
    else
      flash.now[:error] = @field.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @field.update(field_params)
      redirect_to edit_field_path(@field), notice: I18n.t('fields.successful_created')
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
