module GS1
  # Batch or lot number: AI (10)
  #
  # The GS1 Application Identifier (10) indicates that the GS1 Application Identifier data field contains a
  # batch or lot number. The batch or lot number associates an item with information the manufacturer
  # considers relevant for traceability of the trade item to which the element string is applied. The data may
  # refer to the trade item itself or to items contained. The number may be, for example, a production lot
  # number, a shift number, a machine number, a time, or an internal production code. The data is
  # alphanumeric and may include all characters contained in figure 7.11-1.
  #
  # Note: The batch or lot number is not part of the unique identification of a trade item.
  #
  #                           Figure 3.4.1-1. Format of the element string
  #                  |----|------------------------------------------------------|
  #                  | AI |                 Batch or lot number                  |
  #                  |----|------------------------------------------------------|
  #                  | 10 | X1 -------------> variable length -------------> X20 |
  #                  |----|------------------------------------------------------|
  #
  # The data transmitted by the barcode reader means that the element string denoting a batch or lot
  # number has been captured. As this element string is an attribute of a particular item, it must be
  # processed together with the GTIN of the trade item to which it relates. When indicating this element
  # string in the non-HRI text section of a barcode label, the following data title SHOULD be used (see
  # also section 3.2): BATCH/LOT
  #
  # Source: https://www.gs1.org/sites/default/files/docs/barcodes/GS1_General_Specifications.pdf
  #
  class Batch < Record
    AI = AI::BATCH_LOT

    define :length, allowed: 1..20
    define :separator
  end
end
