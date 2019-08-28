module GS1
  module Barcode
    # Error collection handler wrapper class for a barcode.
    #
    class Errors
      attr_reader :errors

      def initialize
        @errors = []
      end

      def clear(type)
        errors.reject! { |error| error.type == type }
      end

      def add(error)
        errors << error
      end

      def empty?
        errors.empty?
      end

      def full_messages
        errors.map(&:message)
      end

      alias << add
    end
  end
end
