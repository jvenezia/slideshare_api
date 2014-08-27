require 'spec_helper'

describe SlideshareApi::Model::Slideshow do
  describe 'attributes' do
    let(:slideshow_xml) { Nokogiri::XML(open('spec/fixtures/slideshow.xml').read) }

    subject { SlideshareApi::Model::Slideshow.new slideshow_xml }

    it { expect(subject.id).to eq slideshow_xml.search('ID').text }
    it { expect(subject.title).to eq slideshow_xml.search('Title').text }
    it { expect(subject.description).to eq slideshow_xml.search('Description').text }
    it { expect(subject.username).to eq slideshow_xml.search('Username').text }
    it { expect(subject.url).to eq slideshow_xml.search('URL').text }
    it { expect(subject.embed).to eq slideshow_xml.search('Embed').text }
    it { expect(subject.language).to eq slideshow_xml.search('Language').text }
  end
end