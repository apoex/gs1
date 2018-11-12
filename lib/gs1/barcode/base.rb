module GS1
  module Barcode
    # Base class for a barcode.
    #
    class Base
      include Definitions

      attr_reader :errors

      def initialize(options = {})
        self.class.records.each do |record|
          data = options.fetch(record.underscore_name, nil)

          instance_variable_set("@#{record.underscore_name}", record.new(data))
        end

        @errors = []
      end

      class << self
        def from_scan!(barcode, separator: DEFAULT_SEPARATOR)
          new(scan_to_params!(barcode, separator: separator))
        end

        def from_scan(barcode, separator: DEFAULT_SEPARATOR)
          new(scan_to_params(barcode, separator: separator))
        end

        def scan_to_params!(barcode, separator: DEFAULT_SEPARATOR)
          Tokenizer.new(barcode, separator: separator).to_params!
        end

        def scan_to_params(barcode, separator: DEFAULT_SEPARATOR)
          Tokenizer.new(barcode, separator: separator).to_params
        end
      end
    end
  end
end
