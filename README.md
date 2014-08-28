# SlideshareApi
[![Gem Version](https://badge.fury.io/rb/slideshare_api.svg)](http://badge.fury.io/rb/slideshare_api)
[![Build](https://travis-ci.org/jvenezia/slideshare_api.svg?branch=master)](https://travis-ci.org/jvenezia/slideshare_api)
[![Coverage Status](https://coveralls.io/repos/jvenezia/slideshare_api/badge.png)](https://coveralls.io/r/jvenezia/slideshare_api)

Ruby wrapper for the Slideshare API.

**Warning**: SlideshareApi is currently under heavy development.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slideshare_api'
```

Or install it yourself as:

    $ gem install slideshare_api

## Usage

Get your **API Key** and **Shared Secret** from Slideshare [here](http://fr.slideshare.net/developers/applyforapi).

```ruby
api_key = 'your api key'
shared_secret = 'shared secret'

client = SlideshareApi::Client.new api_key, shared_secret
```

Get a slideshow:
```ruby
# from url...
slideshow_url = 'http://fr.slideshare.net/awesome_slideshow'
slideshow = client.slideshow(slideshow_url: slideshow_url) #=> returns a SlideshareApi::Model::Slideshow

# from id...
slideshow_id = '1234'
slideshow = client.slideshow(slideshow_id: slideshow_id) #=> returns a SlideshareApi::Model::Slideshow

# with optional informations...
slideshow = client.slideshow(slideshow_id: slideshow_id, detailed: true) #=> returns a SlideshareApi::Model::Slideshow
```

## Contributing
Feel free to contribute!

1. Fork it ( https://github.com/jvenezia/slideshare_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
Released under the MIT License, which can be found in `LICENSE.txt`.