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
shared_secret = 'your shared secret'

client = SlideshareApi::Client.new api_key, shared_secret
```

**Get a slideshow:**
```ruby
# from url...
slideshow_url = 'http://fr.slideshare.net/awesome/slideshow'
slideshow = client.slideshow(slideshow_url: slideshow_url) #=> returns a SlideshareApi::Model::Slideshow

# from id...
slideshow_id = '1234'
slideshow = client.slideshow(slideshow_id: slideshow_id) #=> returns a SlideshareApi::Model::Slideshow

# with optional data...
slideshow = client.slideshow(slideshow_id: slideshow_id, detailed: true) #=> returns a SlideshareApi::Model::Slideshow
```

**Get slideshows:**
```ruby
# by tag...
tag = 'ruby'
slideshows = client.slideshows(tag: tag) #=> returns an array of SlideshareApi::Model::Slideshow

# by group...
group = 'group'
slideshows = client.slideshows(group: group) #=> returns an array of SlideshareApi::Model::Slideshow

# by user...
user = 'username'
slideshows = client.slideshows(user: user) #=> returns an array of SlideshareApi::Model::Slideshow

# with optional data...
slideshows = client.slideshows(user: user, detailed: true) #=> returns an array of SlideshareApi::Model::Slideshow
```

**Search slideshows:**
```ruby
query = 'elcurator'
options = {detailed: true, page: 2}
slideshows = client.search(query, options) #=> returns an array of SlideshareApi::Model::Slideshow
```
Optional search parameters:  
* detailed      => default: false, can be: true, false
* page          => default: 1
* per_page      => default: 12, maximum: 50
* language      => default: 'en', can be: '**' (All), 'es' (Spanish), 'pt' (Portuguese), 'fr' (French), 'it' (Italian), 'nl' (Dutch), 'de' (German), 'zh' (Chinese), 'ja' (Japanese), 'ko' (Korean), 'ro' (Romanian), '!!' (Other)
* ordered_by    => default: 'relevance', can be: 'mostviewed', 'mostdownloaded', 'lastest'
* upload_date   => The time period you want to restrict your search to. default: 'any', can be: 'week', 'month', 'year'
* downloadable  => default: all, can be: true, false
* format        => default: 'all', can be: 'pdf' (PDF), 'ppt' (PowerPoint), 'odp' (Open Office), 'pps' (PowerPoint Slideshow), 'pot' (PowerPoint template)
* type          => default: 'all', can be: 'presentations', 'documents', 'webinars', 'videos', 'infographics'

## Contributing
Feel free to contribute!

1. Fork it ( https://github.com/jvenezia/slideshare_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
Released under the MIT License, which can be found in `LICENSE.txt`.