require_relative 'response'
require_relative '../config'
require 'active_support/core_ext'

module StockAgent
  module Quandl
    class Prices
      API_URL = URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES').freeze
      attr_reader :stock_symbol, :start_date, :end_date

      def initialize(stock_symbol, start_date, end_date = nil)
        @stock_symbol = stock_symbol
        validate_dates(start_date, end_date)
      end

      def response
        @response ||= Response.new(Net::HTTP.get_response(request_url))
      end

      private

      def request_url
        if start_date && end_date
          time_range = { 'date.gte': start_date, 'date.lte': end_date }
        elsif start_date
          time_range = { 'date.gte': start_date, 'date.lte': start_date + 5.days }
        end
        @request_url ||= API_URL.dup.tap do |url|
          url.query = URI.encode_www_form(
            {
              api_key: Config.quandl_api_key,
              ticker: stock_symbol
            }.merge(time_range).compact
          )
        end
      end

      def validate_dates(start_date, end_date)
        @start_date = Date.strptime(start_date, '%Y-%m-%d')
        @end_date = Date.strptime(end_date, '%Y-%m-%d') if end_date
      rescue ArgumentError
        raise 'Please enter correct start_date or end_date (optional) in format: %Y-%m-%d (2018-12-25)'
      end
    end
  end
end
