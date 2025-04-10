module GS1
  module Barcode
    module AttributeValidators
      class RecordValidator
        def validate(barcode, attribute_name)
          barcode.class.records.find { |r| r.underscore_name == attribute_name }.tap do |record|
            if record
              yield record
              next
            end

            on_error(barcode, attribute_name)
          end
        end

        private

        def on_error(barcode, attribute_name)
          barcode.errors[attribute_name] << Error.new(:unknown_attribute, persistent: true)
        end
      end
    end
  end
end
