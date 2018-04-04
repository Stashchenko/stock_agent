require 'bigdecimal'

module StockAgent
  module Metrics
    class RateOfReturn
      class << self
        def calculate(initial_value, final_value)
          new(initial_value, final_value).send(:calculate)
        end
      end

      private

      attr_reader :initial_value, :final_value

      def initialize(initial_value, final_value)
        @initial_value = initial_value
        @final_value = final_value
      end

      def calculate
        (final_value - initial_value) / initial_value
      end
    end
  end
end
