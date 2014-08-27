require 'spec_helper'

describe SlideshareApi::Model::Slideshow do
  describe 'attributes' do
    let(:slideshow_xml) { Nokogiri::XML(open('spec/fixtures/slideshow.xml').read) }

    subject { SlideshareApi::Model::Slideshow.new slideshow_xml }

    it { expect(subject.original_slideshow_xml).to eq slideshow_xml }
    it { expect(subject.id).to eq slideshow_xml.search('ID').text }
    it { expect(subject.title).to eq slideshow_xml.search('Title').text }
    it { expect(subject.description).to eq slideshow_xml.search('Description').text }
    it { expect(subject.status).to eq slideshow_xml.search('Status').text }
    it { expect(subject.username).to eq slideshow_xml.search('Username').text }
    it { expect(subject.url).to eq slideshow_xml.search('URL').text }
    it { expect(subject.thumbnail_url).to eq slideshow_xml.search('ThumbnailURL').text }
    it { expect(subject.thumbnail_size).to eq slideshow_xml.search('ThumbnailSize').text }
    it { expect(subject.thumbnail_small_url).to eq slideshow_xml.search('ThumbnailSmallURL').text }
    it { expect(subject.embed).to eq slideshow_xml.search('Embed').text }
    it { expect(subject.created_at).to eq Time.parse slideshow_xml.search('Created').text }
    it { expect(subject.updated_at).to eq Time.parse slideshow_xml.search('Updated').text }
    it { expect(subject.language).to eq slideshow_xml.search('Language').text }
    it { expect(subject.format).to eq slideshow_xml.search('Format').text }

    context 'it is downloadable' do
      before { slideshow_xml.search('Download').first.content = 1 }
      it { expect(subject.is_downloadable).to eq true }
    end

    context 'it is not downloadable' do
      before { slideshow_xml.search('Download').first.content = 0 }
      it { expect(subject.is_downloadable).to eq false }
    end

    it { expect(subject.slideshow_type).to eq slideshow_xml.search('SlideshowType').text }

    context 'it is in contest' do
      before { slideshow_xml.search('InContest').first.content = 1 }
      it { expect(subject.is_in_contest).to eq true }
    end

    context 'it is not in contest' do
      before { slideshow_xml.search('InContest').first.content = 0 }
      it { expect(subject.is_in_contest).to eq false }
    end

    it { expect(subject.user_id).to eq slideshow_xml.search('UserID').text }
    it { expect(subject.ppt_location).to eq slideshow_xml.search('PPTLocation').text }
    it { expect(subject.stripped_title).to eq slideshow_xml.search('StrippedTitle').text }
    it { expect(subject.tags).to eq slideshow_xml.search('Tag').map(&:text) }
    it { expect(subject.download_count).to eq slideshow_xml.search('NumDownloads').text }
    it { expect(subject.view_count).to eq slideshow_xml.search('NumViews').text }
    it { expect(subject.comment_count).to eq slideshow_xml.search('NumComments').text }
    it { expect(subject.favorite_count).to eq slideshow_xml.search('NumFavorites').text }
    it { expect(subject.slide_count).to eq slideshow_xml.search('NumSlides').text }
    it { expect(subject.related_slideshow_ids).to eq slideshow_xml.search('RelatedSlideshowID').map(&:text) }
    it { expect(subject.privacy_level).to eq slideshow_xml.search('PrivacyLevel').text }

    context 'it is flagged' do
      before { slideshow_xml.search('FlagVisible').first.content = 1 }
      it { expect(subject.is_flagged).to eq true }
    end

    context 'it is not flagged' do
      before { slideshow_xml.search('FlagVisible').first.content = 0 }
      it { expect(subject.is_flagged).to eq false }
    end

    context 'it is visible' do
      before { slideshow_xml.search('ShowOnSS').first.content = 1 }
      it { expect(subject.is_visible).to eq true }
    end

    context 'it is not visible' do
      before { slideshow_xml.search('ShowOnSS').first.content = 0 }
      it { expect(subject.is_visible).to eq false }
    end

    context 'url is secret' do
      before { slideshow_xml.search('SecretURL').first.content = 1 }
      it { expect(subject.url_is_secret).to eq true }
    end

    context 'url is not secret' do
      before { slideshow_xml.search('SecretURL').first.content = 0 }
      it { expect(subject.url_is_secret).to eq false }
    end

    context 'it is embaddable' do
      before { slideshow_xml.search('AllowEmbed').first.content = 1 }
      it { expect(subject.is_embaddable).to eq true }
    end

    context 'url is not embaddable' do
      before { slideshow_xml.search('AllowEmbed').first.content = 0 }
      it { expect(subject.is_embaddable).to eq false }
    end

    context 'it is visible by contacts' do
      before { slideshow_xml.search('ShareWithContacts').first.content = 1 }
      it { expect(subject.is_visible_by_contacts).to eq true }
    end

    context 'url is not visible by contacts' do
      before { slideshow_xml.search('ShareWithContacts').first.content = 0 }
      it { expect(subject.is_visible_by_contacts).to eq false }
    end
  end
end