require 'bigdecimal'

module StockAgent
  module Metrics
    class MaxDrawdown
      class << self
        def calculate(values)
          new(values).send(:calculate)
        end
      end

      private

      attr_reader :values

      def initialize(values)
        @values = values.dup
      end

      def calculate
        { range_min_max: largest_drop, drawdown: RateOfReturn.calculate(largest_drop.max, largest_drop.min) }
      end

      # largest_drop in all ranges
      def largest_drop
        @largest_drop ||=
          peak_values.map { |peak_to_peak| Range.new(*peak_to_peak.minmax) }
                     .max_by { |range| range.max - range.min }
      end

      # Split by peak periods
      # for example: input -> [172.3, 169.26, 174.55, 171.96, 173.47, 172.08, 175.37, 173.05]
      # first iteration: [175.37, 173.05]
      # second iteration: [174.55, 171.96, 173.47, 172.08]
      # third iteration: [172.3, 169.26]
      # sorted by dates and split by peaks with reverse
      # [[172.3, 169.26], [174.55, 171.96, 173.47, 172.08], [175.37, 173.05]]
      def peak_values
        peak_values = []
        tmp_values = values.dup
        peak_values << tmp_values.slice!(tmp_values.index(tmp_values.max)..-1) until tmp_values.empty?
        peak_values.reverse
      end
    end
  end
end
