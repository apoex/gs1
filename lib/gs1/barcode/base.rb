module GS1
  module Barcode
    # Base class for a barcode.
    #
    class Base
      include Definitions

      def initialize(options = {})
        self.class.records.each do |record|
          data = options.fetch(record.underscore_name, nil)

          instance_variable_set("@#{record.underscore_name}", record.new(data))
        end
      end

      def errors
        @errors ||= []
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
