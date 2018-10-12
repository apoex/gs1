module GS1
  module Validations
    # Ensures correct length validation.
    #
    module LengthValidation
      def validate_length
        errors << 'Invalid length' unless valid_length?
      end

      def valid_length?
        self.class.barcode_length == data&.size ||
          self.class.allowed_lengths.include?(data&.size)
      end
    end
  end
end
