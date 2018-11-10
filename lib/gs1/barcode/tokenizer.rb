module GS1
  module Barcode
    # Class for parsing barcodes. Uses {Segment} for splitting up the individual
    # parts.
    #
    class Tokenizer
      attr_reader :data, :separator, :params

      def initialize(data, separator: "\u001E")
        @data = data
        @separator = separator
        @params = {}
      end

      def to_params
        @to_params ||= segment_to_params(data)
      end

      def to_params!
        @to_params ||= segment_to_params(data, true)
      end

      private

      def segment_to_params(input, bang = false)
        segment_from_input(input, bang) do |segment|
          next if segment.to_params.empty?

          params.merge!(segment.to_params)
          next if segment.rest.empty?

          segment_to_params(segment.rest, bang)
        end

        params
      end

      def segment_from_input(input, bang)
        Segment.new(input, separator: separator).tap do |segment|
          segment.validate! if bang
          yield segment if block_given?
        end
      end
    end
  end
end
