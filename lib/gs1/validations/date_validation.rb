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

        ::Date.parse(data)

        true
      rescue TypeError, ArgumentError
        false
      end
    end
  end
end
