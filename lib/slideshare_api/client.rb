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
      params.merge!(slideshow_url: cleaned_url(options[:slideshow_url])) if options[:slideshow_url]
      params.merge!(slideshow_id: options[:slideshow_id]) if options[:slideshow_id]
      params.merge!(detailed: 1) if options[:detailed]
      SlideshareApi::Model::Slideshow.new get('get_slideshow', params)
    end

    def slideshows(options = {})
      params = {}
      if options[:tag]
        params.merge!(tag: options[:tag])
        path = 'get_slideshows_by_tag'
      elsif options[:group]
        params.merge!(group_name: options[:group])
        path = 'get_slideshows_by_group'
      elsif options[:user]
        params.merge!(username_for: options[:user])
        path = 'get_slideshows_by_user'
      else
        raise SlideshareApi::Error, 'Required Parameter Missing'
      end

      params.merge!(detailed: 1) if options[:detailed]
      get(path, params).search('Slideshow').map { |s| SlideshareApi::Model::Slideshow.new(s) }
    end

    def search(query)
      params = {}
      params.merge!(q: query)
      get('search_slideshows', params).search('Slideshow').map { |s| SlideshareApi::Model::Slideshow.new(s) }
    end

    private

    def get(path, params)
      xml_response = Nokogiri::XML(@connection.get(path, api_validation_params.merge(params)).body)
      check_error xml_response
      xml_response
    end

    def cleaned_url(url)
      url.split('?')[0]
    end

    def check_error(xml_response)
      error = xml_response.search('SlideShareServiceError')
      raise SlideshareApi::Error, xml_response.search('Message').text unless error.empty?
    end

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