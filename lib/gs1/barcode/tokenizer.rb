module GS1
  module Barcode
    # Class for parsing barcodes. Uses {Segment} for splitting up the individual
    # parts.
    #
    class Tokenizer
      attr_reader :data, :separator, :params

      def initialize(data, separator: GS1.configuration.barcode_separator, ai_classes: GS1.ai_classes)
        @data = data
        @separator = separator
        @params = []
        @ai_classes = ai_classes
      end

      def to_params
        @to_params ||= segment_to_params(data)
      end

      def to_params!
        @to_params ||= segment_to_params(data, true)
      end

      private

      attr_reader :ai_classes

      # rubocop:disable Style/OptionalBooleanParameter
      def segment_to_params(input, bang = false)
        # rubocop:enable Style/OptionalBooleanParameter
        segment_from_input(input, bang) do |segment|
          next if segment.to_params.empty?

          params << segment.to_params

          next if segment.rest.empty?

          segment_to_params(segment.rest, bang)
        end

        params
      end

      def segment_from_input(input, bang)
        Segment.new(input, separator: separator, ai_classes: ai_classes).tap do |segment|
          segment.validate! if bang
          yield segment if block_given?
        end
      end
    end
  end
end
