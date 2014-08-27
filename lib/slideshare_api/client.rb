require 'faraday'
require 'faraday_middleware'
require 'digest/sha1'
require 'nokogiri'

module SlideshareApi
  class Client
    SLIDESHARE_API_URL = 'https://www.slideshare.net/api/2'

    attr_accessor :connection, :api_key, :shared_secret

    def initialize(api_key, shared_secret)
      @api_key = api_key
      @shared_secret = shared_secret
      build_connection
    end

    def slideshow(options = {})
      params = {}
      params.merge!({slideshow_url: options[:slideshow_url]}) if options[:slideshow_url]
      params.merge!({slideshow_id: options[:slideshow_id]}) if options[:slideshow_id]
      params.merge!({detailed: 1}) if options[:detailed]
      SlideshareApi::Model::Slideshow.new Nokogiri::XML(@connection.get('get_slideshow', api_validation_params.merge(params)).body)
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