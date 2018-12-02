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
    include Extensions::DateMonthBased

    AI = AI::USE_BY
  end
end
