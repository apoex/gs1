require 'date'

module GS1
  module Extensions
    # Extension for a GS1 date. Ensures correct formating and validation.
    #
    module Date
      def self.included(base)
        base.define :date
        base.define :length, barcode: 6
      end

      def initialize(date)
        if date.respond_to?(:strftime)
          super(date.strftime('%y%m%d'))
        else
          super
        end
      end

      def to_date
        ::Date.parse(data)
      end
    end
  end
end
