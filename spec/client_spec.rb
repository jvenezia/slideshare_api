require 'spec_helper'

describe SlideshareApi::Client do
  let(:api_key) { 'api key' }
  let(:shared_secret) { 'shared secret' }
  let(:slideshare_client) { SlideshareApi::Client.new api_key, shared_secret }
  let(:connection) { slideshare_client.connection }
  let(:api_validation_params) { slideshare_client.send(:api_validation_params) }

  describe '.connection' do
    it { expect(connection).to be_a(Faraday::Connection) }
    it { expect("#{connection.url_prefix.scheme}://#{connection.url_prefix.host}#{connection.url_prefix.path}").to eq(SlideshareApi::Client::SLIDESHARE_API_URL) }
  end

  describe '.api_validation_params' do
    subject { slideshare_client.send(:api_validation_params) }
    it { should eq({api_key: api_key, ts: Time.now.to_i, hash: Digest::SHA1.hexdigest("#{shared_secret}#{Time.now.to_i}")}) }
  end

  describe '.slideshow' do
    let(:slideshow_raw_xml) { open('spec/fixtures/slideshow.xml').read }

    before { expect(connection).to receive(:body).and_return(slideshow_raw_xml) }

    context 'get from slideshow url' do
      let(:slideshow_url) { 'http://fr.slideshare.net/jeremyvenezia/prerequis-pour-appliquer-le-lean-startup-en-entreprise' }

      before { expect(connection).to receive(:get).with('get_slideshow', api_validation_params.merge({slideshow_url: slideshow_url})).and_return(connection) }

      subject { slideshare_client.slideshow slideshow_url: slideshow_url }

      it { should eql? SlideshareApi::Model::Slideshow.new(Nokogiri::XML(slideshow_raw_xml)) }
    end

    context 'get from slideshow id' do
      let(:slideshow_id) { '1234' }

      before { expect(connection).to receive(:get).with('get_slideshow', api_validation_params.merge({slideshow_id: slideshow_id})).and_return(connection) }

      subject { slideshare_client.slideshow slideshow_id: slideshow_id }

      it { should eql? SlideshareApi::Model::Slideshow.new(Nokogiri::XML(slideshow_raw_xml)) }
    end
  end
end