module GS1
  module Validations
    # Ensures correct length validation.
    #
    module LengthValidation
      def validate_length(options = {})
        errors << 'Invalid length' unless valid_length?(options)
      end

      def valid_length?(options)
        normalize_allowed(options[:allowed]).include?(data&.size)
      end

      private

      def normalize_allowed(allowed)
        case allowed
        when Range then allowed.to_a
        when Array then allowed.flatten
        else [allowed]
        end
      end
    end
  end
end
