# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.4'

gem 'activerecord-postgis-adapter'
gem 'bootsnap', require: false
gem 'importmap-rails'
gem 'jbuilder'
gem 'pagy'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.4'
gem 'ransack'
gem 'redis', '>= 4.0.1'
gem 'rgeo'
gem 'rgeo-geojson'
gem 'rgeo-proj4'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development do
  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'rubocop', '~> 1.48', require: false
  gem 'rubocop-i18n', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
