module StockAgent
  class Renderer
    def initialize
      @notifiers = []
      @out_buffer = []
    end

    def add_notifier(notifier)
      @notifiers << notifier
    end

    def show_final_result
      @notifiers.each { |notifier| notifier.notify @out_buffer.join(' ') }
      @out_buffer = []
    end

    def print_all(data)
      @out_buffer << "\n\rStock by day:\n\r"
      data.each do |p_data|
        @out_buffer << "#{p_data[:date]}: Closed at #{p_data[:close]} (#{p_data[:low]} ~ #{p_data[:high]})\n\r"
      end
    end

    def render_return_rate(price_first, price_last, result)
      @out_buffer << "\n\rReturn: #{price_last[:close] - price_first[:close]} [#{result}%] (#{price_first[:close]}"
      @out_buffer << " on #{price_first[:date]} -> #{price_last[:close]} on #{price_last[:date]})\n\r"
    end

    def prepare_drawdowns
      @out_buffer << "\n\rDrawdowns by date:\n\r"
    end

    def render_max_drawdown(max_drawdown, p_data)
      @out_buffer << 'Maximum drawdown:'
      build_drawdown(max_drawdown, p_data)
    end

    def build_drawdown(drawdown, p_data)
      @out_buffer << "#{drawdown}% (#{p_data[:high]} on #{p_data[:date]} -> #{p_data[:low]} on #{p_data[:date]})\n\r"
    end
  end
end
