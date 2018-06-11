module SlideshareApi
  module Model
    class Slideshow
      attr_accessor :original_slideshow_xml,
                    :id, :title, :stripped_title, :description, :status,
                    :created_at, :updated_at,
                    :username, :user_id,
                    :url, :thumbnail_url, :thumbnail_size, :embed,
                    :thumbnail_small_url, :thumbnail_medium_url, :thumbnail_large_url,
                    :language, :format, :type,
                    :is_downloadable, :is_in_contest,
                    :ppt_location,
                    :tags,
                    :download_count, :view_count, :comment_count, :favorite_count,
                    :slide_count,
                    :related_slideshow_ids,
                    :is_private, :is_not_flagged, :url_is_secret, :is_embaddable, :is_visible, :is_visible_by_contacts

      def initialize(slideshow_xml = nil)
        @original_slideshow_xml = slideshow_xml
        setup_attributes_from_xml if @original_slideshow_xml
      end

      def ==(other)
        other.class == self.class && other.state == self.state
      end

      protected

      def state
        self.instance_variables.reject { |item| item == :@original_slideshow_xml }.map { |variable| self.instance_variable_get variable }
      end

      private

      def setup_attributes_from_xml
        @id = integer_from_xml('ID')
        @title = text_from_xml('Title')
        @description = text_from_xml('Description')
        @status = status_from_xml
        @username = text_from_xml('Username')
        @url = text_from_xml('URL')
        @thumbnail_url = text_from_xml('ThumbnailURL')
        @thumbnail_size = text_from_xml('ThumbnailSize')
        @thumbnail_small_url = text_from_xml('ThumbnailSmallURL')
        @thumbnail_medium_url = text_from_xml('ThumbnailXLargeURL')
        @thumbnail_large_url = text_from_xml('ThumbnailXXLargeURL')
        @embed = text_from_xml('Embed')
        @created_at = Time.parse text_from_xml('Created')
        @updated_at = Time.parse text_from_xml('Updated')
        @language = text_from_xml('Language')
        @format = text_from_xml('Format')
        @is_downloadable = boolean_from_xml('Download')
        @type = type_from_xml
        @is_in_contest = boolean_from_xml('InContest')
        @user_id = integer_from_xml('UserID')
        @ppt_location = text_from_xml('PPTLocation')
        @stripped_title = text_from_xml('StrippedTitle')
        @tags = text_list_from_xml('Tag')
        @download_count = integer_from_xml('NumDownloads')
        @view_count = integer_from_xml('NumViews')
        @comment_count = integer_from_xml('NumComments')
        @favorite_count = integer_from_xml('NumFavorites')
        @slide_count = integer_from_xml('NumSlides')
        @related_slideshow_ids = integer_list_from_xml('RelatedSlideshowID')
        @is_private = boolean_from_xml('PrivacyLevel')
        @is_not_flagged = boolean_from_xml('FlagVisible')
        @is_visible = boolean_from_xml('ShowOnSS')
        @url_is_secret = boolean_from_xml('SecretURL')
        @is_embaddable = boolean_from_xml('AllowEmbed')
        @is_visible_by_contacts = boolean_from_xml('ShareWithContacts')
      end

      def text_from_xml(attribute_name)
        node = @original_slideshow_xml.search(attribute_name)
        node.text unless node.empty?
      end

      def text_list_from_xml(attribute_name)
        node = @original_slideshow_xml.search(attribute_name)
        node.map(&:text) unless node.empty?
      end

      def boolean_from_xml(attribute_name)
        node = @original_slideshow_xml.search(attribute_name)
        node.first.content == '1' unless node.empty?
      end

      def integer_from_xml(attribute_name)
        text = text_from_xml(attribute_name)
        text.to_i if text
      end

      def integer_list_from_xml(attribute_name)
        text_list = text_list_from_xml(attribute_name)
        text_list.map(&:to_i) if text_list
      end

      def status_from_xml
        case integer_from_xml('Status')
          when 0 then
            :queued_for_conversion
          when 1 then
            :converting
          when 2 then
            :converted
          else
            :conversion_failed
        end
      end

      def type_from_xml
        case integer_from_xml('SlideshowType')
          when 0 then
            :presentation
          when 1 then
            :document
          when 2 then
            :portfolio
          else
            :video
        end
      end
    end
  end
end