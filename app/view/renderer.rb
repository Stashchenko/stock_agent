module StockAgent
  class Renderer
    def initialize
      @notifiers = []
    end

    def add_notifier(notifier)
      @notifiers << notifier
    end

    def print_all(data)
      result = ["\n\rStock by day:\n\r"]
      data.each do |p_data|
        result << "#{p_data[:date]}: Closed at #{p_data[:close]} (#{p_data[:low]} ~ #{p_data[:high]})\n\r"
      end
      print(result)
    end

    def render_return_rate(price_first, price_last, result)
      mess = "\n\rReturn: #{price_last[:close] - price_first[:close]} [#{result}%] (#{price_first[:close]}"
      mess += " on #{price_first[:date]} -> #{price_last[:close]} on #{price_last[:date]})\n\r"
      print(mess)
    end

    def prepare_drawdowns(drawdown, p_data)
      @drawdowns_out ||= ["\n\rDrawdowns by date:\n\r"]
      @drawdowns_out << build_drawdown(drawdown, p_data)
    end

    def render_drawdowns
      print @drawdowns_out if @drawdowns_out.present?
      @drawdowns_out = []
    end

    def render_max_drawdown(max_drawdown, p_data)
      print "Maximum drawdown: #{build_drawdown(max_drawdown, p_data)}"
    end

    private

    def build_drawdown(drawdown, p_data)
      "#{drawdown}% (#{p_data[:high]} on #{p_data[:date]} -> #{p_data[:low]} on #{p_data[:date]})\n\r"
    end

    def print(message)
      @notifiers.each { |notifier| notifier.notify message }
    end
  end
end
