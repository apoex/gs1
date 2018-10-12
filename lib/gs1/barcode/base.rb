module GS1
  module Barcode
    # Base class for a barcode.
    #
    class Base
      include Definitions

      class UnknownRecordError < StandardError; end

      attr_reader :errors

      def initialize(options = {})
        self.class.records.each do |record|
          data = options.fetch(record.underscore_name, nil)

          instance_variable_set("@#{record.underscore_name}", record.new(data))
        end

        @errors = []
      end

      class << self
        def from_scan(barcode, separator: "\u001E")
          new(scan_to_params(barcode, separator: separator))
        end

        def scan_to_params(barcode, separator: "\u001E")
          data = barcode.chars

          {}.tap do |params|
            params.merge!(scan_to_param(data, separator)) until data.empty?
          end
        end

        private

        def scan_to_param(data, separator)
          record = record_from_data(data)

          { record.underscore_name => shift_length(data, record, separator) }
        end

        # Fetch the two first characters (interpreted as AI) from the remaining
        # data and try to find record class. If no record class was found, fetch
        # a third character and try again, and then finally a forth, as no AI
        # currently have more then 4 characters.
        def record_from_data(data)
          ai_variants = []

          record = process_ai_variants(ai_variants, data, 2) ||
                   process_ai_variants(ai_variants, data, 1) ||
                   process_ai_variants(ai_variants, data, 1)

          return record if record

          raise UnknownRecordError, "Unable to retrieve record from application identifier(s) #{ai_variants.join(', ')}"
        end

        def process_ai_variants(ai_variants, data, shifts)
          ai_variants << ai_variants.last.to_s + data.shift(shifts).join

          AI_CLASSES[ai_variants.last]
        end

        def shift_length(data, record, separator)
          return data.shift(record.barcode_length).join if record.barcode_length

          if data.find_index(separator) && data.find_index(separator) < record.barcode_max_length
            shift_variable_length(data, separator)
          else
            data.shift(record.barcode_max_length).join
          end
        end

        def shift_variable_length(data, separator)
          data.shift(data.find_index(separator)).join.tap do
            data.shift unless data.empty? # Shift separator character
          end
        end
      end
    end
  end
end
