require 'date'

module GS1
  module Extensions
    # Extension for a GS1 date. Ensures correct formating and validation.
    #
    # OBS! Month-based expiry
    #
    # Expiry dates for a batch of medicinal product are generally set by month, rather than day. If a batch
    # expires in March 2021, for example, it expires at the very end of the month. From the 1st April 2021, the EMVS
    # will report that the pack identifier has expired if it has not already been decommissioned for some other reason.
    #
    # Manufacturers represent expiry by month in one of two ways. They either set the expiry date to be the last day of
    # the month or they set the day component of the date (DD) to '00'. Examples are shown below:
    #
    # Format A: 210331
    # Format B: 210300
    #
    # These two formats effectively indicate the same expiry date. The first specifies a specific day (the last day of
    # the month). The second specifies only the month of expiry.
    #
    # The format used in the barcodes must be exactly the same as the format used within the EMVS. If the manufacturer
    # uploads batch data to the European Hub using one format, but prints the barcodes using the other, the dates will
    # not match and the national system will raise 'potential falsified medicine' alerts. In this case, the packs
    # cannot be supplied until the manufacturer corrects the data within the EMVS.
    #
    module DateMonthBased
      def self.included(base)
        base.define :date_month_based
        base.define :length, barcode: 6
      end

      def initialize(date)
        if date.respond_to?(:strftime)
          super(date.strftime('%y%m%d'))
        else
          super(date)
        end
      end

      def to_date
        to_date_format_a || to_date_format_b
      end

      private

      def to_date_format_a
        ::Date.strptime(data, '%y%m%d')
      rescue TypeError, ArgumentError
        nil
      end

      def to_date_format_b
        ::Date.strptime(data, '%y%m00').next_month.prev_day
      rescue TypeError, ArgumentError
        nil
      end
    end
  end
end
