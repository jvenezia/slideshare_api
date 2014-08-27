require 'spec_helper'

describe SlideshareApi::Model::Slideshow do
  describe 'attributes' do
    let(:slideshow_xml) { Nokogiri::XML(open('spec/fixtures/slideshow.xml').read) }

    subject { SlideshareApi::Model::Slideshow.new slideshow_xml }

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
    it { expect(subject.download).to eq slideshow_xml.search('Download').text }
    it { expect(subject.slideshow_type).to eq slideshow_xml.search('SlideshowType').text }
    it { expect(subject.in_contest).to eq slideshow_xml.search('InContest').text }
  end
end