module GS1
  # Expiration date: AI (17)
  #
  # The GS1 Application Identifier (17) indicates that the GS1 Application Identifier data fields contain
  # an expiration date. The expiration date is the date that determines the limit of consumption or use
  # of a product/coupon. Its meaning is determined based on the trade item context (e.g., for food, the
  # date will indicate the possibility of a direct health risk resulting from use of the product after the
  # date, for pharmaceutical products, it will indicate the possibility of an indirect health risk resulting
  # from the ineffectiveness of the product after the date). It is often referred to as "use by date" or
  # "maximum durability date."
  #
  # Note: A retailer may use this to determine a date that after which, they will no longer
  # merchandise the product. Currently, there are implementations of best before date which are
  # interpreted in their processes as date to Sell By.
  #
  # The structure is:
  #
  # - Year: the tens and units of the year (e.g., 2003 = 03), which is mandatory.
  # - Month: the number of the month (e.g., January = 01), which is mandatory.
  # - Day: the number of the day of the relevant month (e.g., second day = 02); if it is not necessary
  # to specify the day, the field must be filled with two zeros.
  #
  # Note: When it is not necessary to specify the day (the Day field is filled with two zeros), the
  # resultant data string SHALL be interpreted as the last day of the noted month including any
  # adjustment for leap years (e.g., "130200" is "2013 February 28", "160200" is "2016 February
  # 29", etc.).
  #
  # Note: This element string can only specify dates ranging from 49 years in the past to 50
  # years in the future. Determination of the correct century is explained in section 7.12.
  #
  #                          Figure 3.4.5-1. Format of the element string
  #                           |----|-----------------------------------|
  #                           |    |          Best before date         |
  #                           |    |-----------|-----------|-----------|
  #                           | AI |   Year    |   Month   |    Day    |
  #                           |    |           |           |           |
  #                           |----|-----------|-----------|-----------|
  #                           | 15 |   N1 N2   |   N3 N4   |   N5 N6   |
  #                           |----|-----------|-----------|-----------|
  #
  # The data transmitted from the barcode reader means that the element string denoting a best before
  # date has been captured. As this element string is an attribute of a trade item, it must be processed
  # together with the GTIN of the trade item to which it relates.
  #
  # When indicating this element string in the non-HRI text section of a barcode label, the following data
  # title SHOULD be used (see also section 3.2): BEST BEFORE or BEST BY
  #
  # Source: https://www.gs1.org/sites/default/files/docs/barcodes/GS1_General_Specifications.pdf
  #
  class ExpirationDate < Record
    include Extensions::Date

    AI = AI::USE_BY

    #
    # Month-based expiry
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
