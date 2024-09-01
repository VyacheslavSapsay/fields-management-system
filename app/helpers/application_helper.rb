module ApplicationHelper
  FLASH_TYPES = {
    'notice' => 'alert alert-success',
    'error' => 'alert alert-danger',
    'alert' => 'alert alert-warning'
  }.freeze

  def flash_class(level)
    FLASH_TYPES[level] || 'alert alert-info'
  end
end
