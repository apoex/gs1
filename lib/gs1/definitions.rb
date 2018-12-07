module GS1
  # Module for handling definitions.
  #
  module Definitions
    class InvalidDefinitionType < StandardError; end
    class MissingLengthDefinition < StandardError; end
    class UnknownDefinition < StandardError; end

    def self.included(base)
      base.extend ClassMethods
    end

    # Adding defintion class methods.
    #
    module ClassMethods
      attr_reader :definitions

      DEFINITIONS = %i[check_digit date date_month_based length separator].freeze

      def define(key, options = {})
        raise UnknownDefinition, "#{key} is not a valid definition" unless DEFINITIONS.include?(key)

        @definitions ||= {}

        definitions[key] = send("normalize_#{key}_options", options)
      end

      # Currently no support for options.
      def normalize_check_digit_options(_options)
        {}
      end

      # Currently no support for options.
      def normalize_date_options(_options)
        {}
      end

      # Currently no support for options.
      def normalize_date_month_based_options(_options)
        {}
      end

      # Boolean value
      def normalize_separator_options(_options)
        true
      end

      # Defaults barcode length to allowed length if not explicitly defined, only
      # if there is one significant allowed.
      def normalize_length_options(options)
        options[:allowed] = normalize_multiple_option(options[:allowed] || options[:barcode])
        options[:barcode] = normalize_singlural_option(options[:barcode])
        options[:max_barcode] = options[:allowed]&.last

        options
      end

      def normalize_multiple_option(option_value)
        case option_value
        when nil then nil
        when Range then option_value.to_a
        when Array then option_value
        else [option_value]
        end
      end

      def normalize_singlural_option(option_value)
        return unless option_value

        raise InvalidDefinitionType unless option_value.is_a?(Numeric)

        option_value
      end

      def separator?
        definitions[:separator]
      end

      def barcode_length
        lengths[:barcode]
      end

      def barcode_max_length
        lengths[:max_barcode]
      end

      def allowed_lengths
        lengths[:allowed]
      end

      def lengths
        definitions[:length] || raise(MissingLengthDefinition)
      end
    end
  end
end
