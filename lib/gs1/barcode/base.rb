module GS1
  module Barcode
    # Base class for a barcode.
    #
    class Base
      include Definitions

      def initialize(options = {})
        options.each do |(attribute_name, data)|
          record = validate_record_attribute_name(attribute_name)

          next unless record

          instance_variable_set("@#{attribute_name}", record.new(data))
        end

        @params_order = options.to_h.keys
      end

      def errors
        @errors ||= Errors.new
      end

      class << self
        def from_scan!(barcode, separator: GS1.configuration.barcode_separator)
          new(scan_to_params!(barcode, separator: separator))
        end

        def from_scan(barcode, separator: GS1.configuration.barcode_separator)
          new(scan_to_params(barcode, separator: separator))
        end

        def scan_to_params!(barcode, separator: GS1.configuration.barcode_separator)
          Tokenizer.new(barcode, separator: separator).to_params!
        end

        def scan_to_params(barcode, separator: GS1.configuration.barcode_separator)
          Tokenizer.new(barcode, separator: separator).to_params
        end
      end
    end
  end
end
