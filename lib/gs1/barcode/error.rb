module GS1
  module Barcode
    # Error wrapper class for a barcode.
    #
    class Error
      attr_reader :type, :message

      def initialize(type, message)
        @type = type
        @message = message
      end
    end
  end
end
