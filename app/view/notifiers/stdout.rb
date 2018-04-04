module StockAgent
  class Stdout
    extend NotifyNormalizer

    def self.notify(text)
      print normalize_input(text)
    end
  end
end
