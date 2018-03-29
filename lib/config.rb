require 'singleton'

module StockAgent
  module Lib
    class Config
      include Singleton

      class << self
        def quandl_api_key
          instance.quandl_api_key
        end
      end

      def quandl_api_key
        @quandl_api_key ||= ENV['QUANDL_API_KEY']
      end
    end
  end
end
