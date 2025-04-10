module GS1
  module Barcode
    class AttributeValidator
      def self.for(configuration:)
        attribute_record_validator = if configuration.ignore_extra_barcode_elements
                                       AttributeValidators::IgnoringRecordValidator
                                     else
                                       AttributeValidators::RecordValidator
                                     end

        new(attribute_record_validator: attribute_record_validator.new)
      end

      def initialize(attribute_record_validator: AttributeValidators::IgnoringRecordValidator.new)
        @attribute_record_validator = attribute_record_validator
      end

      def validate_data(barcode, attribute_name)
        return unless barcode.instance_variable_get("@#{attribute_name}")

        barcode.errors[attribute_name] << Error.new(:already_defined, persistent: true)
      end

      def validate_record(barcode, attribute_name, &block)
        attribute_record_validator.validate(barcode, attribute_name, &block)
      end

      private

      attr_reader :attribute_record_validator
    end
  end
end
