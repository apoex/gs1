module GS1
  # Identification of trade items contained in a logistic unit: AI (02)
  #
  # The GS1 Application Identifier (02) indicates that the GS1 Application Identifier data field includes
  # the GTIN of the contained trade items. The GTIN is used to identify trade items (see section 4).
  #
  # The GTIN for trade items may be a GTIN-8, GTIN-12, GTIN-13 or a GTIN-14. See section 2 for the
  # rules for GTIN formats and mandatory or optional attributes in the various trade item applications.
  #
  # The GTIN of the trade items contained is the GTIN of the highest level of trade item contained in the
  # logistic unit.
  #
  # Note: This element string SHALL be used only on a logistic unit if:
  #
  # - the logistic unit is not itself a trade item; and
  # - all trade items that are contained at the highest level have the same GTIN
  #
  # The check digit is explained in section 7.9. Its verification, which must be carried out in the
  # application software, ensures that the number is correctly composed.
  #
  #                           Figure 3.3.3-1. Format of the element string
  #               |----|-------------------------------------------------------------|
  #               |    |               Global Trade Item Number (GTIN)               |
  #               |    |-----------------------------------------------------|-------|
  #               | AI | GS1-8 Prefix or GS1 Company Prefix   Item reference | Check |
  #               |    | ----------------------------->    <-----------------| digit |
  #               |----|-----------------------------------------------------|-------|
  #       GTIN-8  | 02 | 0   0   0   0   0   0   N1  N2  N3  N4  N5  N6  N7  |  N8   |
  #       GTIN-12 | 02 | 0   0   N1  N2  N3  N4  N5  N6  N7  N8  N9  N10 N11 |  N12  |
  #       GTIN-13 | 02 | 0   N1  N2  N3  N4  N5  N6  N7  N8  N9  N10 N11 N12 |  N13  |
  #       GTIN-14 | 02 | N1  N2  N3  N4  N5  N6  N7  N8  N9  N10 N11 N12 N13 |  N14  |
  #               |----|-----------------------------------------------------|-------|
  #
  # The data transmitted from the barcode reader means that the element string denoting the GTIN of
  # trade items contained in a logistic unit has been captured. This element string must be processed
  # together with the count of trade items, AI (37), which must appear on the same unit (see section
  # 3.6.5). When indicating this element string in the non-HRI text section of a barcode label, the
  # following data title SHOULD be used (see also section 3.2): CONTENT
  #
  # Source: https://www.gs1.org/sites/default/files/docs/barcodes/GS1_General_Specifications.pdf
  #
  class Content < Record
    include Extensions::GTIN

    AI = AI::CONTENT
  end
end
