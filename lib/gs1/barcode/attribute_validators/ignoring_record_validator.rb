module GS1
  module Barcode
    module AttributeValidators
      class IgnoringRecordValidator < RecordValidator
        private

        def on_error(_barcode, _attribute_name); end
      end
    end
  end
end
