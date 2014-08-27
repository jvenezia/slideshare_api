require 'faraday'
require 'faraday_middleware'

Gem.find_files('slideshare_api/**/*.rb').each { |file| require file }