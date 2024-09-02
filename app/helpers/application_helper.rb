# frozen_string_literal: true

require 'pagy/extras/bootstrap'
module ApplicationHelper
  include Pagy::Frontend

  FLASH_TYPES = {
    'notice' => 'alert alert-success',
    'error' => 'alert alert-danger',
    'alert' => 'alert alert-warning'
  }.freeze

  def flash_class(level)
    FLASH_TYPES[level] || 'alert alert-info'
  end

  def sort_direction(column)
    if params.dig(:q, :s) == "#{column} asc"
      'desc'
    else
      'asc'
    end
  end

  def sort_indicator(column)
    if params.dig(:q, :s) == "#{column} asc"
      '↑'
    elsif params.dig(:q, :s) == "#{column} desc"
      '↓'
    else
      ''
    end
  end
end
