module StockAgent
  module NotifyNormalizer
    def normalize_input(text)
      text.is_a?(Array) ? text.join(' ') : text
    end
  end
end
