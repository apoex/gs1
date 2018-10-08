require 'date'

module GS1
  module Extensions
    # Extension for a GS1 date. Ensures correct formating and validation.
    #
    module Date
      def self.included(base)
        base.define :date
      end

      def to_s
        return data.strftime('%y%m%d') if data.is_a?(::Date)

        data
      end

      def to_date
        return data if data.is_a?(::Date)

        ::Date.parse(data)
      end
    end
  end
end
