# frozen_string_literal: true

class Field < ApplicationRecord
  validates :name, :shape, presence: true

  after_save :update_area, if: -> { saved_change_to_shape? }

  private

  def update_area
    projected_factory = RGeo::Geographic.simple_mercator_factory

    projected_shape = RGeo::Feature.cast(shape, factory: projected_factory)
    update(area: projected_shape.area)
  end

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[area created_at id name shape updated_at]
    end
  end
end
