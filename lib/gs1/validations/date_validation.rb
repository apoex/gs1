require 'date'

module GS1
  module Validations
    # Ensures correct date validation.
    #
    module DateValidation
      def validate_date(_options = {})
        errors << 'Invalid date' unless valid_date?
      end

      def valid_date?
        return true if data.is_a?(::Date)

        valid_format_a?(data) || valid_format_b?(data)
      end

      def valid_format_a?(data)
        valid_date_format?(data, '%y%m%d')
      end

      # Read more about this date format in the GS1::ExpirationDate class.
      def valid_format_b?(data)
        valid_date_format?(data, '%y%m00')
      end

      private

      def valid_date_format?(data, pattern)
        ::Date.strptime(data, pattern)

        true
      rescue TypeError, ArgumentError
        false
      end
    end
  end
end
