module GS1
  module Barcode
    # Base class for a barcode.
    #
    class Base
      include Definitions

      def initialize(attributes = {})
        attributes.each do |(name, data)|
          validate_attribute_data(name)
          validate_attribute_record(name) do |record|
            instance_variable_set("@#{name}", record.new(data))
          end
        end

        @params_order = attributes.to_h.keys
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
