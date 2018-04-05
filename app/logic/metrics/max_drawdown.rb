require 'bigdecimal'

module StockAgent
  module Metrics
    class MaxDrawdown
      class << self
        def calculate(values)
          new(values).send(:calculate)
        end

        def peak_values(values)
          new(values).send(:peak_values)
        end
      end

      private

      attr_reader :values

      def initialize(values)
        @values = values.dup
      end

      def calculate
        { range_min_max: largest_drop, drawdown: RateOfReturn.calculate(largest_drop.first[:low], largest_drop.last[:high]) }
      end

      def largest_drop
        return @largest_drop if @largest_drop.present?
        @largest_drop = []
        max_peak = 0
        peak_values.each do |peak_to_peak|
          next unless peak_to_peak.first[:high] - peak_to_peak.last[:low] > max_peak
          max_peak = peak_to_peak.first[:high] - peak_to_peak.last[:low]
          @largest_drop.clear
          @largest_drop << peak_to_peak
        end
        @largest_drop.flatten!
      end

      def peak_values
        peak_values = []
        tmp_values = values.dup
        until tmp_values.empty?
          max = tmp_values.max_by { |v| v[:high] }
          peak_values << tmp_values.slice!(tmp_values.index(max)..-1)
        end
        peak_values.reverse
      end
    end
  end
end
