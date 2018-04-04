module StockAgent
  module App
    class Client
      def execute(stock_symbol, start_date, end_date)
        handler = StockAgent::StockHandler.new(stock_symbol, start_date, end_date)
        handler.add_notifier(StockAgent::Stdout)
        handler.add_notifier(StockAgent::Slack)
        handler.adapter = StockAgent::QuandlAdapter::Prices.new

        handler.show_period
        handler.drawdowns_period
        handler.max_drawdown
        handler.rate_of_return
      end
    end
  end
end
