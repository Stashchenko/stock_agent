module StockAgent
  class AbstractAction
    PRECISION = 1

    attr_accessor :renderer

    def initialize(renderer)
      @renderer = renderer
    end

    protected

    def to_percent(number, precision = PRECISION)
      (number * 100).round(precision).to_f
    end
  end
end
