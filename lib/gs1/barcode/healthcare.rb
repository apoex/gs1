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
        errors.clear

        validate_minimum
        return if level == AIDCMarketingLevels::MINIMUM

        validate_enhanced
        return if level == AIDCMarketingLevels::ENHANCED

        validate_highest
      end

      def validate_minimum
        validate_attribute(:gtin)
      end

      def validate_enhanced
        validate_attribute(:batch)
        validate_attribute(:expiration_date)
      end

      def validate_highest
        validate_attribute(:serial_number)
      end

      def validate_attribute(attribute_name)
        attribute = public_send(attribute_name)

        if attribute.nil?
          errors[attribute_name] << Error.new(:missing)
        elsif !attribute.valid?
          errors[attribute_name] << Error.new(:invalid)
        end
      end
    end
  end
end
