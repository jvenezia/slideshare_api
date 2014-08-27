# SlideshareApi
[![Build](https://travis-ci.org/jvenezia/slideshare_api.svg?branch=master)](https://travis-ci.org/jvenezia/slideshare_api)

Slideshare ruby wrapper for the Slideshare API.

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
slideshow_url = 'http://fr.slideshare.net/awesome_slideshow'
slideshow = client.slideshow(slideshow_url) #=> returns a SlideshareApi::Model::Slideshow
slideshow.id
slideshow.title
slideshow.description
slideshow.username
slideshow.url
slideshow.embed
slideshow.language
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