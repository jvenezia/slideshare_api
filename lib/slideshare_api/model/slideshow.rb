module SlideshareApi
  module Model
    class Slideshow
      attr_accessor :id, :title, :description, :status, :username,
                    :url, :thumbnail_url, :thumbnail_size, :thumbnail_small_url, :embed, :language,
                    :created_at, :updated_at,
                    :format, :download, :slideshow_type, :in_contest

      def initialize(slideshow_xml)
        @id = slideshow_xml.search('ID').text
        @title = slideshow_xml.search('Title').text
        @description = slideshow_xml.search('Description').text
        @status = slideshow_xml.search('Status').text
        @username = slideshow_xml.search('Username').text
        @url = slideshow_xml.search('URL').text
        @thumbnail_url = slideshow_xml.search('ThumbnailURL').text
        @thumbnail_size = slideshow_xml.search('ThumbnailSize').text
        @thumbnail_small_url = slideshow_xml.search('ThumbnailSmallURL').text
        @embed = slideshow_xml.search('Embed').text
        @created_at = Time.parse slideshow_xml.search('Created').text
        @updated_at = Time.parse slideshow_xml.search('Updated').text
        @language = slideshow_xml.search('Language').text
        @format = slideshow_xml.search('Format').text
        @download = slideshow_xml.search('Download').text
        @slideshow_type = slideshow_xml.search('SlideshowType').text
        @in_contest = slideshow_xml.search('InContest').text
      end
    end
  end
end