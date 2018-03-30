require 'net/http'
require 'date'
require 'active_support'
require 'active_support/core_ext'

Dir[File.join(File.expand_path(Dir.pwd), 'lib/**/', '*.rb')].each { |file| require_relative file }
Dir[File.join(File.expand_path(Dir.pwd), 'app/**/', '*.rb')].each { |file| require_relative file }

stock_name = ARGV[0]
start_date = ARGV[1]
end_date = ARGV[2]

StockAgent::App::Client.new.execute(stock_name, start_date, end_date)
