module GS1
  # Serial number: AI (21)
  #
  # The GS1 Application Identifier (21) indicates that the GS1 Application Identifier data field contains a
  # serial number. A serial number is assigned to an entity for its lifetime. When combined with a GTIN,
  # a serial number uniquely identifies an individual item. The serial number field is alphanumeric and
  # may include all characters contained in figure 7.11-1. The manufacturer determines the serial
  # number.
  #
  #                           Figure 3.5.2-1. Format of the element string
  #                  |----|------------------------------------------------------|
  #                  | AI |                    Serial number                     |
  #                  |----|------------------------------------------------------|
  #                  | 21 | X1 -------------> variable length -------------> X20 |
  #                  |----|------------------------------------------------------|
  #
  # The data transmitted from the barcode reader means that the element string denoting a serial
  # number has been captured. As this element string is an attribute of a trade item, it must be
  # processed together with the GTIN of the trade item to which it relates.
  #
  # When indicating this element string in the non-HRI text section of a barcode label, the following data
  # title SHOULD be used (see also section 3.2): SERIAL
  #
  # Source: https://www.gs1.org/sites/default/files/docs/barcodes/GS1_General_Specifications.pdf
  #
  class SerialNumber < Record
    include Extensions::String

    valid_lengths 1..20

    AI = AI::SERIAL
  end
end
