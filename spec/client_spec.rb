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
    context 'there is an error' do
      let(:error_xml) { open('spec/fixtures/error.xml').read }

      before { expect(connection).to receive(:get).and_return(connection) }
      before { expect(connection).to receive(:body).and_return(error_xml) }

      it { expect(-> { slideshare_client.slideshow }).to raise_error(SlideshareApi::Error) }
    end

    context 'there is no error' do
      let(:slideshow_raw_xml) { open('spec/fixtures/slideshow.xml').read }
      before { expect(connection).to receive(:body).and_return(slideshow_raw_xml) }

      context 'get from slideshow url' do
        context 'url has params' do
          let(:slideshow_url_with_params) { 'http://fr.slideshare.net/jeremyvenezia/prerequis-pour-appliquer-le-lean-startup-en-entreprise?ref=http://fr.slideshare.net/?ss' }
          let(:slideshow_url) { 'http://fr.slideshare.net/jeremyvenezia/prerequis-pour-appliquer-le-lean-startup-en-entreprise' }

          before { expect(connection).to receive(:get).with('get_slideshow', api_validation_params.merge({slideshow_url: slideshow_url})).and_return(connection) }

          subject { slideshare_client.slideshow slideshow_url: slideshow_url_with_params }

          it { should eq SlideshareApi::Model::Slideshow.new(Nokogiri::XML(slideshow_raw_xml)) }
        end

        context 'url has no params' do
          let(:slideshow_url) { 'http://fr.slideshare.net/jeremyvenezia/prerequis-pour-appliquer-le-lean-startup-en-entreprise' }

          before { expect(connection).to receive(:get).with('get_slideshow', api_validation_params.merge({slideshow_url: slideshow_url})).and_return(connection) }

          subject { slideshare_client.slideshow slideshow_url: slideshow_url }

          it { should eq SlideshareApi::Model::Slideshow.new(Nokogiri::XML(slideshow_raw_xml)) }
        end
      end

      context 'get from slideshow id' do
        let(:slideshow_id) { '1234' }

        before { expect(connection).to receive(:get).with('get_slideshow', api_validation_params.merge({slideshow_id: slideshow_id})).and_return(connection) }

        subject { slideshare_client.slideshow slideshow_id: slideshow_id }

        it { should eq SlideshareApi::Model::Slideshow.new(Nokogiri::XML(slideshow_raw_xml)) }
      end
    end
  end

  describe '.slideshows' do
    context 'there is an error' do
      context 'there is a param' do
        let(:error_xml) { open('spec/fixtures/error.xml').read }

        before { expect(connection).to receive(:get).and_return(connection) }
        before { expect(connection).to receive(:body).and_return(error_xml) }

        it { expect(-> { slideshare_client.slideshows user: '' }).to raise_error(SlideshareApi::Error) }
      end

      context 'param is missing' do
        it { expect(-> { slideshare_client.slideshows }).to raise_error(SlideshareApi::Error) }
      end
    end

    context 'there is no error' do
      let(:slideshows_raw_xml) { open('spec/fixtures/slideshows.xml').read }
      before { expect(connection).to receive(:body).and_return(slideshows_raw_xml) }

      context 'by tag' do
        let(:tag) { 'ruby' }

        before { expect(connection).to receive(:get).with('get_slideshows_by_tag', api_validation_params.merge({tag: tag})).and_return(connection) }

        subject { slideshare_client.slideshows tag: tag }

        it { should eq Nokogiri::XML(slideshows_raw_xml).search('Slideshow').map { |s| SlideshareApi::Model::Slideshow.new(s) } }
      end

      context 'by group' do
        let(:group) { 'group' }

        before { expect(connection).to receive(:get).with('get_slideshows_by_group', api_validation_params.merge({group_name: group})).and_return(connection) }

        subject { slideshare_client.slideshows group: group }

        it { should eq Nokogiri::XML(slideshows_raw_xml).search('Slideshow').map { |s| SlideshareApi::Model::Slideshow.new(s) } }
      end

      context 'by user' do
        let(:user) { 'jeremyvenezia' }

        before { expect(connection).to receive(:get).with('get_slideshows_by_user', api_validation_params.merge({username_for: user})).and_return(connection) }

        subject { slideshare_client.slideshows user: user }

        it { should eq Nokogiri::XML(slideshows_raw_xml).search('Slideshow').map { |s| SlideshareApi::Model::Slideshow.new(s) } }
      end
    end
  end

  describe '.search' do
    context 'there is an error' do
      let(:error_xml) { open('spec/fixtures/error.xml').read }

      before { expect(connection).to receive(:get).and_return(connection) }
      before { expect(connection).to receive(:body).and_return(error_xml) }

      it { expect(-> { slideshare_client.search('') }).to raise_error(SlideshareApi::Error) }
    end

    context 'there is no error' do
      let(:query) { 'query' }
      let(:slideshows_raw_xml) { open('spec/fixtures/slideshows.xml').read }

      before { expect(connection).to receive(:get).with('search_slideshows', api_validation_params.merge({q: query})).and_return(connection) }
      before { expect(connection).to receive(:body).and_return(slideshows_raw_xml) }

      subject { slideshare_client.search query }

      it { should eq Nokogiri::XML(slideshows_raw_xml).search('Slideshow').map { |s| SlideshareApi::Model::Slideshow.new(s) } }
    end
  end
end