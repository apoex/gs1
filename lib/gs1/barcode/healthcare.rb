module GS1
  module Barcode
    # Barcode for boxes in healthcare business.
    #
    class Healthcare
      ATTRIBUTES = %i[gtin batch expiration_date serial_number].freeze

      REGEX = %r{
        \A
        #{GTIN.ai}(?<gtin>[0-9]{14})
        (#{ExpirationDate.ai}(?<expiration_date>[0-9]{6}))?
        (#{Batch.ai}(?<batch>[A-Za-z0-9]{1,20}))?
        (#{SerialNumber.ai}(?<serial_number>[A-Za-z0-9]{1,20}))?
        \z
      }x

      attr_reader(*ATTRIBUTES)
      attr_reader :errors

      def initialize(options = {})
        @gtin            = GTIN.new(options.fetch(:gtin))
        @batch           = Batch.new(options.fetch(:batch, nil))
        @expiration_date = ExpirationDate.new(options.fetch(:expiration_date, nil))
        @serial_number   = SerialNumber.new(options.fetch(:serial_number, nil))
        @errors          = []
      end

      def self.from_scan(data)
        match = data.match(REGEX)
        attributes = match.names.zip(match.captures).to_h

        key_attributes = attributes.each_with_object({}) do |(key, value), hash|
          hash[key.to_sym] = value
        end

        new(key_attributes)
      end

      def to_s(level: AIDCMarketingLevels::ENHANCED)
        return unless valid?(level: level)

        [gtin.to_ai,
         expiration_date&.to_ai,
         batch&.to_ai,
         serial_number&.to_ai].compact.join
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
        errors << 'Invalid batch' unless batch&.valid?
        errors << 'Invalid expiration date' unless expiration_date&.valid?
      end

      def validate_highest
        errors << 'Invalid serial number' unless serial_number&.valid?
      end
    end
  end
end
