require 'English'
require 'gs1/syntax_dictionary/specification_parser'

module GS1
  module SyntaxDictionary
    # Parses the specification column.
    class SpecificationParser
      def initialize(specification_data)
        @data = specification_data
      end

      # @return [Range<Integer>] returns the length
      def parse
        lengths = components
                  .map { parse_component(_1) }
                  .reduce(Length.new(0, 0), :+)

        lengths.min..lengths.max
      end

      private

      class Length
        attr_reader :min, :max

        def initialize(min, max)
          @min = min
          @max = max
        end

        def +(other) = Length.new(other.calculate_min(min), max + other.max)

        def calculate_min(other_min) = other_min + min
      end

      private_constant :Length

      class OptionalLength < Length
        def calculate_min(other_min) = other_min
      end

      private_constant :OptionalLength

      attr_reader :data

      def components = @components ||= data.split

      # rubocop:disable Metrics/MethodLength
      def parse_component(component)
        types = 'NXYZ'
        fixed = /^[#{types}](?<length>\d+)/
        fixed_optional = /^\[[#{types}](?<length>\d+)\]/
        variable = /^[#{types}]\.\.(?<length>\d+)/
        variable_optional = /^\[[#{types}]\.\.(?<length>\d+)\]/

        case component
        when fixed
          length = $LAST_MATCH_INFO[:length].to_i
          Length.new(length, length)
        when fixed_optional
          length = $LAST_MATCH_INFO[:length].to_i
          OptionalLength.new(length, length)
        when variable
          Length.new(1, $LAST_MATCH_INFO[:length].to_i)
        when variable_optional
          OptionalLength.new(1, $LAST_MATCH_INFO[:length].to_i)
        else
          raise "Invalid format for component of specification column: #{component}"
        end
      end
      # rubocop:enable Metrics/MethodLength
    end
  end
end
