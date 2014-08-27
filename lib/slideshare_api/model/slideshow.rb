module SlideshareApi
  module Model
    class Slideshow
      attr_accessor :id, :title, :description, :username, :url, :embed, :language

      def initialize(slideshow_xml)
        @id = slideshow_xml.search('ID').text
        @title = slideshow_xml.search('Title').text
        @description = slideshow_xml.search('Description').text
        @username = slideshow_xml.search('Username').text
        @url = slideshow_xml.search('URL').text
        @embed = slideshow_xml.search('Embed').text
        @language = slideshow_xml.search('Language').text
      end
    end
  end
end