module StockAgent
  class ReturnAction < AbstractAction
    def call(data)
      price_first = data.first
      price_last = data.last
      result = StockAgent::Metrics::RateOfReturn.calculate(price_first[:adj_close], price_last[:adj_close])
      @renderer.render_return_rate(price_first, price_last, to_percent(result))
    end
  end
end
