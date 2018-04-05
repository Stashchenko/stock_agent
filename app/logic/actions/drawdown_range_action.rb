module StockAgent
  class DrawdownRangeAction < AbstractAction
    def call(data)
      @renderer.prepare_drawdowns
      peaks = StockAgent::Metrics::MaxDrawdown.peak_values(data)
      peaks.each do |peak|
        result = StockAgent::Metrics::MaxDrawdown.calculate(peak)
        @renderer.build_drawdown(to_percent(result[:drawdown]), result[:range_min_max])
      end
    end
  end
end
