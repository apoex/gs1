module GS1
  module Validations
    # Ensures correct length validation.
    #
    module LengthValidation
      def validate_length
        errors << 'Invalid length' unless valid_length?
      end

      def valid_length?
        return false unless data

        valid_barcode_length? || valid_allowed_length?
      end

      def valid_allowed_length?
        self.class.allowed_lengths.include?(data.size)
      end

      def valid_barcode_length?
        self.class.barcode_length == data.size if self.class.barcode_length
      end
    end
  end
end
