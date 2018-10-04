module GS1
  module Extensions
    # Extension for a GS1 GTIN. Ensures correct formating and validation.
    #
    module GTIN
      def self.included(base)
        base.extend         LengthValidation::ClassMethods
        base.send :include, LengthValidation::InstanceMethods
        base.send :include, CheckDigitValidation

        base.valid_lengths [8, 12, 13, 14].freeze

        base.lengths.each do |length|
          define_method "to_gtin_#{length}" do
            data.to_s.rjust(length, '0')
          end
        end
      end

      # Default to GTIN-14 since it is the most common format.
      def to_s
        to_gtin_14
      end

      def validate
        validate_length
        validate_check_digit
      end
    end
  end
end
