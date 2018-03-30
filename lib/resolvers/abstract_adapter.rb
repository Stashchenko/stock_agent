module StockAgent
  module Resolvers
    class AbstractAdapter
      def response(_stock_symbol, _start_date, _end_date = nil)
        raise 'Should implement in specific adapter'
      end
    end
  end
end
