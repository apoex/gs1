module GS1
  module Barcode
    # Base class for a barcode.
    #
    class Base
      include Definitions

      def initialize(attributes = {}, options = {})
        attribute_validator = options[:attribute_validator] || AttributeValidator.new
        attributes.each do |(name, data)|
          attribute_validator.validate_data(self, name)
          attribute_validator.validate_record(self, name) do |record|
            instance_variable_set("@#{name}", record.new(data))
          end
        end

        @params_order = attributes.to_h.keys
      end

      def errors
        @errors ||= Errors.new
      end

      class << self
        def for(attributes, configuration:)
          attribute_validator = AttributeValidator.for(configuration: configuration)
          new(attributes, attribute_validator: attribute_validator)
        end

        def from_scan!(barcode, separator: GS1.configuration.barcode_separator, ai_classes: GS1.ai_classes)
          self.for(
            scan_to_params!(barcode, separator: separator, ai_classes: ai_classes),
            configuration: GS1.configuration
          )
        end

        def from_scan(barcode, separator: GS1.configuration.barcode_separator, ai_classes: GS1.ai_classes)
          self.for(
            scan_to_params(barcode, separator: separator, ai_classes: ai_classes),
            configuration: GS1.configuration
          )
        end

        def scan_to_params!(barcode, separator: GS1.configuration.barcode_separator, ai_classes: GS1.ai_classes)
          Tokenizer.new(barcode, separator: separator, ai_classes: ai_classes)
                   .to_params!
        end

        def scan_to_params(barcode, separator: GS1.configuration.barcode_separator, ai_classes: GS1.ai_classes)
          Tokenizer.new(barcode, separator: separator, ai_classes: ai_classes)
                   .to_params
        end
      end
    end
  end
end
