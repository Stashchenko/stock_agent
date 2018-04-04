require 'singleton'

module StockAgent
  module Lib
    class Config
      include Singleton

      class << self
        def quandl_api_key
          instance.quandl_api_key
        end

        def slack_url
          instance.slack_url
        end
      end

      def quandl_api_key
        @quandl_api_key ||= ENV['QUANDL_API_KEY']
      end

      def slack_url
        @slack_url ||= ENV['SLACK_WEBHOOK_URL']
      end
    end
  end
end
