module GS1
  module Barcode
    # Barcode for boxes in healthcare business.
    #
    class Healthcare < Base
      define_records GTIN, ExpirationDate, Batch, SerialNumber

      def to_s(level: AIDCMarketingLevels::ENHANCED)
        return unless valid?(level: level)

        [gtin.to_ai,
         expiration_date && expiration_date.to_ai,
         batch && batch.to_ai,
         serial_number && serial_number.to_ai].compact.join
      end

      def valid?(level: AIDCMarketingLevels::ENHANCED)
        return false unless AIDCMarketingLevels::ALL.include?(level)

        validate(level)

        errors.empty?
      end

      private

      def validate(level)
        errors.clear

        validate_minimum
        return if level == AIDCMarketingLevels::MINIMUM

        validate_enhanced
        return if level == AIDCMarketingLevels::ENHANCED

        validate_highest
      end

      def validate_minimum
        errors << 'Invalid gtin' unless gtin.valid?
      end

      def validate_enhanced
        errors << 'Invalid batch' unless batch && batch.valid?
        errors << 'Invalid expiration date' unless expiration_date && expiration_date.valid?
      end

      def validate_highest
        errors << 'Invalid serial number' unless serial_number && serial_number.valid?
      end
    end
  end
end
