module GS1
  # Module for handling definitions.
  #
  module Definitions
    class UnknownDefinition < StandardError; end

    def self.included(base)
      base.extend ClassMethods
    end

    # Adding defintion class methods.
    #
    module ClassMethods
      attr_reader :definitions

      DEFINITIONS = %i[check_digit date length].freeze

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

      # Defaults barcode length to allowed length if not explicitly defined, only
      # if there is one significant allowed.
      def normalize_length_options(options)
        options[:allowed] = normalize_multiple_option(options[:allowed])

        options
      end

      def normalize_multiple_option(option_value)
        case option_value
        when Range then option_value.to_a
        when Array then option_value
        else [option_value]
        end
      end

      def allowed_lengths
        lengths[:allowed]
      end

      def lengths
        definitions[:length]
      end
    end
  end
end
