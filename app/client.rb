require_relative '../lib/config'

module StockAgent
  module App
    class Client
      def execute(stock_symbol, start_date, end_date)
        puts stock_symbol, start_date, end_date
        puts "ApiKey #{StockAgent::Lib::Config.quandl_api_key}"
      end
    end
  end
end
