# frozen_string_literal: true

require_relative 'app/client'

stock_name = ARGV[0]
start_date = ARGV[1]
end_date = ARGV[2]

StockAgent::App::Client.new.execute(stock_name, start_date, end_date)
