module StockAgent
  class StockResolver
    attr_accessor :adapter, :start_date, :end_date

    def stock_data(stock_symbol, start_date, end_date)
      validate_dates(start_date, end_date)
      @adapter.response(stock_symbol, @start_date, @end_date)
    end

    private

    def validate_dates(start_date, end_date)
      @start_date = Date.strptime(start_date, '%Y-%m-%d')
      @end_date = Date.strptime(end_date, '%Y-%m-%d') if end_date
    rescue ArgumentError
      raise 'Please enter correct start_date or end_date (optional) in format: %Y-%m-%d (2018-12-25)'
    end
  end
end
