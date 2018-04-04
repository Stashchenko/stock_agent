module StockAgent
  class AllStockAction < AbstractAction
    def call(data)
      @renderer.print_all(data)
    end
  end
end
