module GS1
  module Barcode
    # Barcode for boxes in healthcare business.
    #
    class Healthcare < Base
      define_records GTIN, ExpirationDate, Batch, SerialNumber

      def to_s(level: AIDCMarketingLevels::ENHANCED, separator: GS1.configuration.barcode_separator)
        return unless valid?(level: level)

        @params_order.each_with_object('') do |param, out|
          record = send(param)

          next unless record.to_ai

          out << record.to_ai
          out << separator if record.class.separator? && param != @params_order.last
        end
      end

      def valid?(level: AIDCMarketingLevels::ENHANCED)
        return false unless AIDCMarketingLevels::ALL.include?(level)

        validate(level)

        errors.empty?
      end

      private

      def validate(level)
        errors.clear(:healthcare)

        validate_minimum
        return if level == AIDCMarketingLevels::MINIMUM

        validate_enhanced
        return if level == AIDCMarketingLevels::ENHANCED

        validate_highest
      end

      def validate_minimum
        errors << Error.new(:healthcare, 'Invalid gtin') unless gtin.valid?
      end

      def validate_enhanced
        errors << Error.new(:healthcare, 'Invalid batch') unless batch&.valid?
        errors << Error.new(:healthcare, 'Invalid expiration date') unless expiration_date&.valid?
      end

      def validate_highest
        errors << Error.new(:healthcare, 'Invalid serial number') unless serial_number&.valid?
      end
    end
  end
end
