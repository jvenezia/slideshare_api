module SlideshareApi
  module Model
    class Slideshow
      attr_accessor :original_slideshow_xml,
                    :id, :title, :stripped_title, :description, :status,
                    :created_at, :updated_at,
                    :username, :user_id,
                    :url, :thumbnail_url, :thumbnail_size, :thumbnail_small_url, :embed,
                    :language, :format, :slideshow_type,
                    :is_downloadable, :is_in_contest,
                    :ppt_location,
                    :tags,
                    :download_count, :view_count, :comment_count, :favorite_count,
                    :slide_count,
                    :related_slideshow_ids,
                    :privacy_level, :is_flagged, :url_is_secret, :is_embaddable, :is_visible, :is_visible_by_contacts

      def initialize(slideshow_xml)
        @original_slideshow_xml = slideshow_xml

        @id = text_from_xml('ID')
        @title = text_from_xml('Title')
        @description = text_from_xml('Description')
        @status = text_from_xml('Status')
        @username = text_from_xml('Username')
        @url = text_from_xml('URL')
        @thumbnail_url = text_from_xml('ThumbnailURL')
        @thumbnail_size = text_from_xml('ThumbnailSize')
        @thumbnail_small_url = text_from_xml('ThumbnailSmallURL')
        @embed = text_from_xml('Embed')
        @created_at = Time.parse text_from_xml('Created')
        @updated_at = Time.parse text_from_xml('Updated')
        @language = text_from_xml('Language')
        @format = text_from_xml('Format')
        @is_downloadable = boolean_from_xml('Download')
        @slideshow_type = text_from_xml('SlideshowType')
        @is_in_contest = boolean_from_xml('InContest')
        @user_id = text_from_xml('UserID')
        @ppt_location = text_from_xml('PPTLocation')
        @stripped_title = text_from_xml('StrippedTitle')
        @tags = text_list_from_xml('Tag')
        @download_count = text_from_xml('NumDownloads')
        @view_count = text_from_xml('NumViews')
        @comment_count = text_from_xml('NumComments')
        @favorite_count = text_from_xml('NumFavorites')
        @slide_count = text_from_xml('NumSlides')
        @related_slideshow_ids = text_list_from_xml('RelatedSlideshowID')
        @privacy_level = text_from_xml('PrivacyLevel')
        @is_flagged = boolean_from_xml('FlagVisible')
        @is_visible = boolean_from_xml('ShowOnSS')
        @url_is_secret = boolean_from_xml('SecretURL')
        @is_embaddable = boolean_from_xml('AllowEmbed')
        @is_visible_by_contacts = boolean_from_xml('ShareWithContacts')
      end

      private

      def boolean_from_xml(attribute_name)
        @original_slideshow_xml.search(attribute_name).first.content == '1'
      end

      def text_from_xml(attribute_name)
        @original_slideshow_xml.search(attribute_name).text
      end

      def text_list_from_xml(attribute_name)
        @original_slideshow_xml.search(attribute_name).map(&:text)
      end
    end
  end
end