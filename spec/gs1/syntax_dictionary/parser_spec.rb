require 'gs1/syntax_dictionary/parser'

RSpec.describe GS1::SyntaxDictionary::Parser do
  describe 'parse' do
    def parse(data) = described_class.new(data).parse

    specify 'single line' do
      data = <<~DATA.strip
        00   *?  N18,csum,keyoff1   dlpkey   # SSCC
      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '00', separator_required: false, length: 18..18, title: 'SSCC')
      )
    end

    specify 'multiple lines' do
      data = <<~DATA.strip
        00   *?  N18,csum,keyoff1   dlpkey                          # SSCC
        01   *?  N14,csum,keyoff1   ex=255,37 dlpkey=22,10,21|235   # GTIN
      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '00', separator_required: false, length: 18..18, title: 'SSCC'),
        an_object_having_attributes(ai: '01', separator_required: false, length: 14..14, title: 'GTIN')
      )
    end

    specify 'comments' do
      data = <<~DATA.strip
        # This is the GS1 Barcode Syntax Dictionary.
        00   *?  N18,csum,keyoff1   dlpkey   # SSCC
      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '00', separator_required: false, length: 18..18, title: 'SSCC')
      )
    end

    specify 'empty lines' do
      data = <<~DATA

        00   *?  N18,csum,keyoff1   dlpkey   # SSCC

      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '00', separator_required: false, length: 18..18, title: 'SSCC')
      )
    end

    specify 'AI range' do
      data = <<~DATA.strip
        3100-3105  *?  N6   req=01,02 ex=310n   # NET WEIGHT (kg)
      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '3100', separator_required: false, length: 6..6, title: 'NET WEIGHT (kg)_3100'),
        an_object_having_attributes(ai: '3101', separator_required: false, length: 6..6, title: 'NET WEIGHT (kg)_3101'),
        an_object_having_attributes(ai: '3102', separator_required: false, length: 6..6, title: 'NET WEIGHT (kg)_3102'),
        an_object_having_attributes(ai: '3103', separator_required: false, length: 6..6, title: 'NET WEIGHT (kg)_3103'),
        an_object_having_attributes(ai: '3104', separator_required: false, length: 6..6, title: 'NET WEIGHT (kg)_3104'),
        an_object_having_attributes(ai: '3105', separator_required: false, length: 6..6, title: 'NET WEIGHT (kg)_3105')
      )
    end

    specify 'AI range with title generates unique titles' do
      data = <<~DATA.strip
        3910-3919   ?  N3,iso4217 N..15   req=8020 ex=391n   # AMOUNT
      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '3910', separator_required: true, length: 4..18, title: 'AMOUNT_3910'),
        an_object_having_attributes(ai: '3911', separator_required: true, length: 4..18, title: 'AMOUNT_3911'),
        an_object_having_attributes(ai: '3912', separator_required: true, length: 4..18, title: 'AMOUNT_3912'),
        an_object_having_attributes(ai: '3913', separator_required: true, length: 4..18, title: 'AMOUNT_3913'),
        an_object_having_attributes(ai: '3914', separator_required: true, length: 4..18, title: 'AMOUNT_3914'),
        an_object_having_attributes(ai: '3915', separator_required: true, length: 4..18, title: 'AMOUNT_3915'),
        an_object_having_attributes(ai: '3916', separator_required: true, length: 4..18, title: 'AMOUNT_3916'),
        an_object_having_attributes(ai: '3917', separator_required: true, length: 4..18, title: 'AMOUNT_3917'),
        an_object_having_attributes(ai: '3918', separator_required: true, length: 4..18, title: 'AMOUNT_3918'),
        an_object_having_attributes(ai: '3919', separator_required: true, length: 4..18, title: 'AMOUNT_3919')
      )
    end

    specify 'without flags' do
      data = <<~DATA.strip
        21             X..20   req=01,03,8006 ex=235   # SERIAL
      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '21', separator_required: true, length: 1..20, title: 'SERIAL')
      )
    end

    specify 'without attributes' do
      data = <<~DATA.strip
        400         ?  X..30   # ORDER NUMBER
      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '400', separator_required: true, length: 1..30, title: 'ORDER NUMBER')
      )
    end

    specify 'without title' do
      data = <<~DATA.strip
        8110        ?  X..70,couponcode
      DATA

      expect(parse(data)).to contain_exactly(
        an_object_having_attributes(ai: '8110', separator_required: true, length: 1..70, title: '8110')
      )
    end
  end
end
