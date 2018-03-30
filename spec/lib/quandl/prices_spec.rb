require 'net/http'
require_relative '../../../lib/quandl/prices'

RSpec.describe StockAgent::Quandl::Prices do
  describe '#request_url' do
    let(:request_url) { URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=valid_api_key&date.gte=2018-01-02&date.lte=2018-01-07&ticker=AAPL') }
    let(:dummy_body) { File.new('spec/fixtures/aapl_2018-01-02.json') }

    before do
      stub_request(:get, request_url)
        .with(headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Host' => 'www.quandl.com',
                'User-Agent' => 'Ruby'
              })
        .to_return(status: 200, body: dummy_body, headers: {})
    end

    after { WebMock.reset! }

    context 'with api_key' do
      context 'with stock_symbol and start date' do
        let(:stock_symbol) { 'AAPL' }
        let(:start_date) { '2018-01-02' }

        context 'with date' do
          subject do
            StockAgent::Quandl::Prices.new(stock_symbol, start_date).response
          end

          it 'return valid URL' do
            is_expected.to be_instance_of StockAgent::Quandl::Response
          end
        end

        context 'with date(range)' do
          subject do
            StockAgent::Quandl::Prices.new(stock_symbol, '2018-01-02', '2018-01-07').response
          end

          it 'return valid response' do
            is_expected.to be_instance_of StockAgent::Quandl::Response
          end
        end

        context 'with invalid date' do
          subject do
            StockAgent::Quandl::Prices.new(stock_symbol, '2011112').response
          end

          it 'should raise error' do
            expect { subject }.to raise_error
          end
        end
      end
    end
  end
end
