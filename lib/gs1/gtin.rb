module GS1
  # Identification of a trade item (GTIN): AI (01)
  #
  # The GS1 Application Identifier (01) indicates that the GS1 Application Identifier data field contains a
  # GTIN. The GTIN is used to identify trade items (see section 4).
  #
  # The GTIN for trade items may be a GTIN-8, GTIN-12, GTIN-13 or a GTIN-14. See section 2.1 for the
  # rules for GTIN formats and mandatory or optional attributes in the various trade item applications.
  #
  # The check digit is explained in section 7.9. Its verification, which must be carried out in the
  # application software, ensures that the number is correctly composed.
  #
  #                           Figure 3.3.2-1. Format of the element string
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
  # The data transmitted from the barcode reader means that the element string denoting the GTIN of a
  # fixed measure trade item has been captured.
  #
  # When indicating this element string in the non-HRI text section of a barcode label, the following data
  # title SHOULD be used (see also section 3.2): GTIN
  #
  # Source: https://www.gs1.org/sites/default/files/docs/barcodes/GS1_General_Specifications.pdf
  #
  class GTIN < Record
    include Extensions::GTIN

    AI = AI::GTIN
  end
end
