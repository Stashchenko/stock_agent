module StockAgent
  class StockHandler
    PRECISION = 1
    attr_accessor :renderer, :resolver

    delegate :add_notifier, to: :renderer
    delegate :adapter=, to: :resolver

    def initialize(stock_symbol, start_date, end_date)
      @renderer = StockAgent::Renderer.new
      @resolver = StockAgent::StockResolver.new
      @stock_symbol = stock_symbol
      @start_date = start_date
      @end_date = end_date
    end

    def show_period
      @renderer.print_all(price_datas)
    end

    def rate_of_return
      price_first = price_datas.first
      price_last = price_datas.last
      result = StockAgent::Metrics::RateOfReturn.calculate(price_first[:adj_close], price_last[:adj_close])
      @renderer.render_return_rate(price_first, price_last, to_percent(result))
    end

    def drawdowns_period
      price_datas.each do |p_data|
        result = StockAgent::Metrics::MaxDrawdown.calculate([p_data[:high], p_data[:low]])
        @renderer.prepare_drawdowns(to_percent(result[:drawdown]), p_data)
      end
      @renderer.render_drawdowns
    end

    def max_drawdown
      values = []
      price_datas.each do |price_data|
        values << price_data[:high]
        values << price_data[:low]
      end
      result = StockAgent::Metrics::MaxDrawdown.calculate(values)
      @renderer.render_max_drawdown(to_percent(result[:drawdown]), find_data_by_drawdown(result))
    end

    private

    def find_data_by_drawdown(result)
      price_datas.find do |data|
        data[:high] == result[:range_min_max].max &&
          data[:low] == result[:range_min_max].min
      end
    end

    def price_datas
      @price_datas ||= @resolver.stock_data(@stock_symbol, @start_date, @end_date).data
    end

    def to_percent(number, precision = PRECISION)
      (number * 100).round(precision).to_f
    end
  end
end
