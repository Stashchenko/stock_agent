module StockAgent
  class DrawdownRangeAction < AbstractAction
    def call(data)
      @renderer.prepare_drawdowns
      data.each do |p_data|
        result = StockAgent::Metrics::MaxDrawdown.calculate([p_data[:high], p_data[:low]])
        @renderer.build_drawdown(to_percent(result[:drawdown]), p_data)
      end
    end
  end
end
