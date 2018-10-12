module GS1
  module Extensions
    # Extension for a GS1 GTIN. Ensures correct formating and validation.
    #
    module GTIN
      def self.included(base)
        base.define :check_digit
        base.define :length, allowed: [8, 12, 13, 14].freeze, barcode: 14

        base.allowed_lengths.each do |length|
          define_method "to_gtin_#{length}" do
            data.to_s.rjust(length, '0')
          end
        end
      end

      # Default to GTIN-14 since it is the most common format.
      def to_s
        to_gtin_14
      end
    end
  end
end
