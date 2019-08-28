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

      def messages
        errors.each_with_object({}) do |error, hash|
          hash[error.attribute] ||= []
          hash[error.attribute] << error.human_message
        end
      end

      def full_messages
        errors.map do |error|
          "#{error.human_message} #{error.human_attribute}"
        end
      end

      alias << add
    end
  end
end
