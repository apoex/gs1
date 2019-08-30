module GS1
  module Barcode
    # Error wrapper class for a barcode.
    #
    class Error
      attr_reader :message

      def initialize(message, persistent: false)
        @message = message
        @persistent = persistent
      end

      def persistent?
        @persistent
      end

      def human_message
        message.to_s.tr('_', ' ').capitalize
      end

      def hash
        message.hash
      end

      def eql?(other)
        @message == other.message
      end
    end
  end
end
