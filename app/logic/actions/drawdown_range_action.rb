module StockAgent
  class DrawdownRangeAction < AbstractAction
    def call(data)
      data.each do |p_data|
        result = StockAgent::Metrics::MaxDrawdown.calculate([p_data[:high], p_data[:low]])
        @renderer.prepare_drawdowns(to_percent(result[:drawdown]), p_data)
      end
      @renderer.render_drawdowns
    end
  end
end
