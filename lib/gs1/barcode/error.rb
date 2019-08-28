module GS1
  module Barcode
    # Error wrapper class for a barcode.
    #
    class Error
      attr_reader :type, :attribute, :message

      def initialize(type, attribute, message)
        @type = type
        @attribute = attribute
        @message = message
      end

      def human_attribute
        attribute.to_s.tr('_', ' ')
      end

      def human_message
        message.to_s.tr('_', ' ').capitalize
      end
    end
  end
end
