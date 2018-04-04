module StockAgent
  class StockHandler
    attr_accessor :renderer, :resolver

    delegate :add_notifier, to: :renderer
    delegate :adapter=, to: :resolver

    def initialize(stock_symbol, start_date, end_date)
      @renderer = StockAgent::Renderer.new
      @resolver = StockAgent::StockResolver.new

      @actions = allowed_actions.map { |a| a.new(@renderer) }

      @stock_symbol = stock_symbol
      @start_date = start_date
      @end_date = end_date
    end

    def call
      @actions.each {|a| a.call(price_datas)}
    end

    private

    def price_datas
      raise 'Please specify data adapter for StockHandler' if @resolver.adapter.blank?
      @price_datas ||= @resolver.stock_data(@stock_symbol, @start_date, @end_date).data
    end

    def allowed_actions
      [AllStockAction, DrawdownRangeAction, MaxDrawdownAction, ReturnAction]
    end

  end
end
