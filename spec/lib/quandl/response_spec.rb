require 'net/http'
require_relative '../../../lib/quandl/response'

RSpec.describe StockAgent::Quandl::Response do
  let(:net_http_response) { Net::HTTP.get_response(request_url) }
  let(:request_url) { URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=valid_api_key&date=2018-01-02&ticker=AAPL') }
  let(:dummy_body) { File.new('spec/fixtures/aapl_2018-01-02.json') }

  before do
    stub_request(:get, request_url)
      .with(headers: {
              'Accept': '*/*',
              'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host': 'www.quandl.com',
              'User-Agent': 'Ruby'
            })
      .to_return(status: 200, body: dummy_body, headers: {})
  end

  after { WebMock.reset! }

  describe 'Get raw data' do
    subject { StockAgent::Quandl::Response.new(net_http_response).data }

    it 'with valid Net::HTTP response and single data' do
      expect(subject).to be_instance_of(Array)
      expect(subject[0][:stock_name]).to eq 'AAPL'
      expect(subject[0][:date]).to eq '2018-01-02'
      expect(subject[0][:open]).to eq 173.36
      expect(subject[0][:high]).to eq 175.0
      expect(subject[0][:low]).to eq 173.05
      expect(subject[0][:close]).to eq 174.96
      expect(subject[0][:volume]).to eq 24_997_274.0
      expect(subject[0][:ex_dividend]).to eq 0.0
      expect(subject[0][:split_ratio]).to eq 1.0
      expect(subject[0][:adj_open]).to eq 173.36
      expect(subject[0][:adj_high]).to eq 175.0
      expect(subject[0][:adj_low]).to eq 173.05
      expect(subject[0][:adj_close]).to eq 174.96
      expect(subject[0][:adj_volume]).to eq 24_997_274.0
    end
  end
end
