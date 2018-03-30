require_relative '../lib/config'
require_relative '../lib/quandl/prices'

module StockAgent
  module App
    class Client
      def execute(stock_symbol, start_date, end_date)
        response = StockAgent::Quandl::Prices.new(stock_symbol, start_date, end_date).response
        response.data.each do |d|
          puts d
        end
      end
    end
  end
end
