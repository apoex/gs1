module GS1
  module Barcode
    # Error collection handler wrapper class for a barcode.
    #
    class Errors
      attr_reader :errors

      def initialize
        @errors = {}
      end

      def [](attribute_name)
        errors[attribute_name] ||= []
      end

      def clear
        errors.each_value do |errs|
          errs.select!(&:persistent?)
        end
      end

      def empty?
        errors.values.flatten.empty?
      end

      def messages
        errors.each_with_object({}) do |(attribute_name, errors), hash|
          hash[attribute_name] = errors.uniq.map(&:human_message)
        end
      end

      def full_messages
        errors.flat_map do |(attribute_name, errors)|
          errors.uniq.map do |error|
            "#{error.human_message} #{attribute_name.to_s.tr('_', ' ')}"
          end
        end
      end
    end
  end
end
