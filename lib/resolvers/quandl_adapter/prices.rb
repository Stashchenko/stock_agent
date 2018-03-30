module StockAgent
  module QuandlAdapter
    class Prices < StockAgent::Resolvers::AbstractAdapter
      API_URL = URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES').freeze

      def response(stock_symbol, start_date, end_date = nil)
        url = request_url(stock_symbol, start_date, end_date)
        @response ||= Response.new(Net::HTTP.get_response(url))
      end

      private

      def request_url(stock_symbol, start_date, end_date = nil)
        if start_date && end_date
          time_range = { 'date.gte': start_date, 'date.lte': end_date }
        elsif start_date
          time_range = { 'date.gte': start_date, 'date.lte': start_date + 5.days }
        end
        @request_url ||= API_URL.dup.tap do |url|
          url.query = URI.encode_www_form(
            {
              api_key: StockAgent::Lib::Config.quandl_api_key,
              ticker: stock_symbol
            }.merge(time_range).compact
          )
        end
      end
    end
  end
end
