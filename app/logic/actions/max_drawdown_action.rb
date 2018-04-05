module StockAgent
  class MaxDrawdownAction < AbstractAction
    def call(data)
      result = StockAgent::Metrics::MaxDrawdown.calculate(data)
      @renderer.render_max_drawdown(to_percent(result[:drawdown]), result[:range_min_max])
    end
  end
end
