module StockAgent
  class MaxDrawdownAction < AbstractAction
    def call(data)
      values = []
      @data = data
      data.each do |price_data|
        values << price_data[:high]
        values << price_data[:low]
      end
      result = StockAgent::Metrics::MaxDrawdown.calculate(values)
      @renderer.render_max_drawdown(to_percent(result[:drawdown]), find_data_by_drawdown(result))
    end

    private

    def find_data_by_drawdown(result)
      @data.find do |data|
        data[:high] == result[:range_min_max].max &&
          data[:low] == result[:range_min_max].min
      end
    end
  end
end
