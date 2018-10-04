module GS1
  module Extensions
    # Extension for a GS1 string. Ensures correct formating and validation.
    #
    module String
      def self.included(base)
        base.extend         LengthValidation::ClassMethods
        base.send :include, LengthValidation::InstanceMethods
      end

      def validate
        validate_length
      end
    end
  end
end
