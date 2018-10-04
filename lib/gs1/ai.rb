# Application identifiers constants.
#
# Version 18.0
# Date: Jan 2018
# Read more: https://www.gs1.org/standards/barcodes-epcrfid-id-keys/gs1-general-specifications
# Change log: https://www.gs1.org/genspecs/gscn_archive
#
module GS1
  module AI
    #
    # GS1 Application Identifiers starting with digit 0

    # Serial Shipping Container Code (SSCC)
    SSCC = '00'.freeze

    # Global Trade Item Number (GTIN)
    GTIN = '01'.freeze

    # GTIN of contained trade items
    CONTENT = '02'.freeze

    #
    # GS1 Application Identifiers starting with digit 1

    # Batch or lot number
    BATCH_LOT = '10'.freeze

    # Production date (YYMMDD)
    PROD_DATE = '11'.freeze

    # Due date (YYMMDD)
    DUE_DATE = '12'.freeze

    # Packaging date (YYMMDD)
    PACK_DATE = '13'.freeze

    # Best before date (YYMMDD)
    BEST_BY = '15'.freeze

    # Sell by date (YYMMDD)
    SELL_BY = '16'.freeze

    # Expiration date (YYMMDD)
    USE_BY = '17'.freeze

    #
    # GS1 Application Identifiers starting with digit 2

    # Variant number
    VARIANT = '20'.freeze

    # Serial number
    SERIAL = '21'.freeze

    # Consumer product variant
    CPV = '22'.freeze

    # Additional item identification
    ADDITIONAL_ID = '240'.freeze

    # Customer part number
    CUST_PART_NO = '241'.freeze

    # Made-to-Order variation number
    MTO_VARIANT = '242'.freeze

    # Packaging component number
    PCN = '243'.freeze

    # Secondary serial number
    SECONDARY_SERIAL = '250'.freeze

    # Reference to source entity
    REF_TO_SOURCE = '251'.freeze

    # Global Document Type Identifier (GDTI)
    GDTI = '253'.freeze

    # GLN extension component
    GLN_EXTENSION_COMPONENT = '254'.freeze

    # Global Coupon Number (GCN)
    GCN = '255'.freeze

    #
    # GS1 Application Identifiers starting with digit 3

    # Count of items (variable measure trade item)
    VAR_COUNT = '30'.freeze

    #
    # GS1 Application Identifiers starting with digit 4

    # Customer's purchase order number
    ORDER_NUMBER = '400'.freeze

    # Global Identification Number for Consignment (GINC)
    GINC = '401'.freeze

    # Global Shipment Identification Number (GSIN)
    GSIN = '402'.freeze

    # Routing code
    ROUTE = '403'.freeze

    # Ship to - Deliver to Global Location Number
    SHIP_TO_LOC = '410'.freeze

    # Bill to - Invoice to Global Location Number
    BILL_TO = '411'.freeze

    # Purchased from Global Location Number
    PURCHASE_FROM = '412'.freeze

    # Ship for - Deliver for - Forward to Global Location Number
    SHIP_FOR_LOC = '413'.freeze

    # Identification of a physical location - Global Location Number
    LOC_NO = '414'.freeze

    # Global Location Number of the invoicing party
    PAY_TO = '415'.freeze

    # GLN of the production or service location
    PROD_SERV_LOC = '416'.freeze

    # Ship to - Deliver to postal code within a single postal authority
    SHIP_TO_POST = '420'.freeze

    # Ship to - Deliver to postal code with ISO country code
    SHIP_TO_POST_ISO = '421'.freeze

    # Country of origin of a trade item
    ORIGIN = '422'.freeze

    # Country of initial processing
    COUNTRY_INITIAL_PROCESS = '423'.freeze

    # Country of processing
    COUNTRY_PROCESS = '424'.freeze

    # Country of disassembly
    COUNTRY_DISASSEMBLY = '425'.freeze

    # Country covering full process chain
    COUNTRY_FULL_PROCESS = '426'.freeze

    # Country subdivision Of origin
    ORIGIN_SUBDIVISION = '427'.freeze

    #
    # GS1 Application Identifiers starting with digit 7

    # NATO Stock Number (NSN)
    NSN = '7001'.freeze

    # UN/ECE meat carcasses and cuts classification
    MEAT_CUT = '7002'.freeze

    # Expiration date and time
    EXPIRY_TIME = '7003'.freeze

    # Active potency
    ACTIVE_POTENCY = '7004'.freeze

    # Catch area
    CATCH_AREA = '7005'.freeze

    # First freeze date
    FIRST_FREEZE_DATE = '7006'.freeze

    # Harvest date
    HARVEST_DATE = '7007'.freeze

    # Species for fishery purposes
    AQUATIC_SPECIES = '7008'.freeze

    # Fishing gear type
    FISHING_GEAR_TYPE = '7009'.freeze

    # Production method
    PROD_METHOD = '7010'.freeze

    # Refurbishment lot ID
    REFURB_LOT = '7020'.freeze

    # Functional status
    FUNC_STAT = '7021'.freeze

    # Revision status N4+X..20 (FNC1)
    REV_STAT = '7022'.freeze

    # Global Individual Asset Identifier (GIAI) of an assembly
    GIAI_ASSEMBLY = '7023'.freeze

    # Number of processor with ISO Country Code N4+N3+X..27 (FNC1)
    PROCESSOR = '703'.freeze

    #
    # GS1 Application Identifiers starting with digit 8

    # Roll products (width, length, core diameter, direction, splices)
    DIMENSIONS = '8001'.freeze

    # Cellular mobile telephone identifier
    CMT_NO = '8002'.freeze

    # Global Returnable Asset Identifier (GRAI)
    GRAI = '8003'.freeze

    # Global Individual Asset Identifier (GIAI)
    GIAI = '8004'.freeze

    # Price per unit of measure
    PRICE_PER_UNIT = '8005'.freeze

    # Identification of the components of a trade item
    GCTIN = '8006'.freeze

    # International Bank Account Number (IBAN)
    IBAN = '8007'.freeze

    # Date and time of production
    PROD_TIME = '8008'.freeze

    # Component / Part Identifier (CPID)
    CPID = '8010'.freeze

    # Component / Part Identifier serial number (CPID SERIAL)
    CPID_SERIAL = '8011'.freeze

    # Software version
    VERSION = '8012'.freeze

    # Global Model Number
    GMN = '8013'.freeze

    # Global Service Relation Number to identify the relationship between an organisation offering
    # services and the provider of services
    GSRN_PROVIDER = '8017'.freeze

    # Global Service Relation Number to identify the relationship between an organisation offering
    # services and the recipient of services
    GSRN_RECIPIENT = '8018'.freeze

    # Service Relation Instance Number (SRIN)
    SRIN = '8019'.freeze

    # Payment slip reference number
    REF_NO = '8020'.freeze

    # Coupon code identification for use in North America
    COUPON_CODE = '8110'.freeze

    # Loyalty points of a coupon
    POINTS = '8111'.freeze

    # Extended Packaging URL
    PRODUCT_URL = '8200'.freeze

    #
    # GS1 Application Identifiers starting with digit 9

    # Information mutually agreed between trading partners
    INTERNAL = '90'.freeze

    # Company internal information
    INTERNAL1 = '91'.freeze

    # Company internal information
    INTERNAL2 = '92'.freeze

    # Company internal information
    INTERNAL3 = '93'.freeze

    # Company internal information
    INTERNAL4 = '94'.freeze

    # Company internal information
    INTERNAL5 = '95'.freeze

    # Company internal information
    INTERNAL6 = '96'.freeze

    # Company internal information
    INTERNAL7 = '97'.freeze

    # Company internal information
    INTERNAL8 = '98'.freeze

    # Company internal information
    INTERNAL9 = '99'.freeze
  end
end
