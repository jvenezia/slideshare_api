require 'digest/sha1'

module SlideshareApi
  class Client
    SLIDESHARE_API_URL = 'https://www.slideshare.net/api/2'

    attr_accessor :connection, :api_key, :shared_secret

    def initialize(api_key, shared_secret)
      @api_key = api_key
      @shared_secret = shared_secret
      build_connection
    end

    def slideshow(slideshow_url)
      @connection.get('get_slideshow', api_validation_params.merge({slideshow_url: slideshow_url})).body
    end

    private

    def build_connection
      @connection = Faraday.new(url: SLIDESHARE_API_URL) do |faraday|
        faraday.request :json
        faraday.adapter Faraday.default_adapter
      end
    end

    def api_validation_params
      timestamp = Time.now.to_i
      hash = Digest::SHA1.hexdigest "#{@shared_secret}#{timestamp}"
      {api_key: @api_key, ts: timestamp, hash: hash}
    end
  end
end