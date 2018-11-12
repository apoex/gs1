module GS1
  module Validations
    # Ensures correct check digit validation.
    #
    module CheckDigitValidation
      def validate_check_digit
        errors << 'Check digit mismatch' unless valid_check_digit?
      end

      def valid_check_digit?
        return false unless data

        GS1::CheckDigitCalculator.with_sequence(data[0..-2]) == data
      rescue ArgumentError
        false
      end
    end
  end
end
