module StockAgent
  module App
    class Client
      def execute(stock_symbol, start_date, end_date)
        resolver = StockAgent::StockResolver.new(StockAgent::QuandlAdapter::Prices.new)
        response = resolver.stock_data(stock_symbol, start_date, end_date)
        response.data.each do |d|
          puts d
        end
      end
    end
  end
end
