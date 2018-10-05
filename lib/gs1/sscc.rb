module GS1
  #
  # Identification of a logistic unit (SSCC): AI (00)
  #
  # The GS1 Application Identifier (00) indicates that the GS1 Application Identifier data field contains an
  # SSCC (Serial Shipping Container Code). The SSCC is used to identify logistic units (see section 2.2).
  #
  # The extension digit is used to increase the capacity of the serial reference within the SSCC. It is
  # assigned by the company that constructs the SSCC. The extension digit ranges from 0-9.
  #
  # The GS1 Company Prefix is allocated by GS1 Member Organisations to the company that allocates
  # the SSCC - here the physical builder or the brand owner of the logistic unit (see section 1.4.4). It
  # makes the SSCC unique worldwide but does not identify the origin of the unit.
  #
  # The structure and content of the serial reference is at the discretion of owner of the GS1 Company
  # Prefix to uniquely identify each logistic unit.
  #
  # The check digit is explained in section 7.9. Its verification, which must be carried out in the
  # application software, ensures that the number is correctly composed.
  #
  #                           Figure 3.3.1-1. Format of the element string
  #       |----|-----------------------------------------------------------------------------|
  #       |    |                    SSCC (Serial Shipping Container Code)                    |
  #       |    |-----------|---------------------------------------------------------|-------|
  #       | AI | Extension | GS1 Company Prefix                     Serial reference | Check |
  #       |    |   digit   | -------------->                 <-----------------------| digit |
  #       |----|-----------|---------------------------------------------------------|-------|
  #       | 00 |    N1     | N2 N3 N4 N5 N6 N7 N8 N9 N10 N11 N12 N13 N14 N15 N16 N17 |  N18  |
  #       |----|-----------|---------------------------------------------------------|-------|
  #
  # The data transmitted from the barcode reader means that the element string denoting the SSCC of
  # a logistic unit has been captured. When indicating this element string in the non-HRI text section of
  # a barcode label, the following data title SHOULD be used (see also section 3.2): SSCC
  #
  # Source: https://www.gs1.org/sites/default/files/docs/barcodes/GS1_General_Specifications.pdf
  #
  class SSCC < Record
    AI = AI::SSCC

    validate :check_digit
    validate :length, allowed: 18
  end
end
