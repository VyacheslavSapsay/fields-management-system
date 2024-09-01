class Field < ApplicationRecord
  validates :name, :shape, presence: true

  after_save :update_area, if: -> { saved_change_to_shape? }

  private

  def update_area
    projected_factory = RGeo::Geographic.simple_mercator_factory

    projected_shape = RGeo::Feature.cast(self.shape, factory: projected_factory)
    self.update(area: projected_shape.area)
  end
end
