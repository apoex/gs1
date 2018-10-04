module GS1
  module Extensions
    # Ensures correct check digit validation.
    #
    module CheckDigitValidation
      def valid_check_digit?
        CheckDigit.with_sequence(data[0..-2]) == data
      rescue CheckDigit::InvalidError
        false
      end

      def validate_check_digit
        errors << 'Check digit mismatch' unless valid_check_digit?
      end
    end
  end
end
