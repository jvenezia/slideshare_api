require 'bundler/setup'
Bundler.setup

require 'slideshare_api'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true
end