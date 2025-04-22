require 'gs1/syntax_dictionary/parser'

RSpec.describe GS1::SyntaxDictionary::SpecificationParser do
  def parse(specification_data)
    described_class.new(specification_data).parse
  end

  context 'Type: Numeric' do
    specify 'variable length' do
      expect(parse('N..20')).to eq(1..20)
    end

    specify 'fixed length' do
      expect(parse('N18')).to eq(18..18)
    end

    specify 'fixed length and multiple linters' do
      expect(parse('N18,csum,keyoff1 ')).to eq(18..18)
    end

    specify 'variable length with single linter' do
      expect(parse('N..12,nozeroprefix')).to eq(1..12)
    end

    specify 'multiple components' do
      expect(parse('N3 N4')).to eq(7..7)
    end

    specify 'multiple components of different types' do
      expect(parse('N1 X1 X1 X1')).to eq(4..4)
    end

    specify 'multiple components and linters' do
      expect(parse('N4,nonzero N5,nonzero N3,nonzero N1,winding N1')).to eq(14..14)
    end

    specify 'fixed length and optional variable length' do
      expect(parse('N13,csum,key [N..12]')).to eq(13..25)
    end

    specify 'fixed length and variable length' do
      expect(parse('N3,iso3166999 X..27')).to eq(4..30)
    end

    specify 'two column fixed length and variable length' do
      expect(parse('N1,zero N13,csum,key [X..16]')).to eq(14..30)
    end

    specify 'two column fixed length with linters' do
      expect(parse('N10,latitude N10,longitude')).to eq(20..20)
    end

    specify 'fixed length and optional fixed length' do
      expect(parse('N2 [N4]')).to eq(2..6)
    end
  end

  context 'Type: CEST 82' do
    specify 'fixed length' do
      expect(parse('X2')).to eq(2..2)
    end

    specify 'variable length' do
      expect(parse('X..20')).to eq(1..20)
    end
  end

  context 'Type: CEST 39' do
    specify 'variable length with linter' do
      expect(parse('Y..30,key')).to eq(1..30)
    end
  end

  context 'Type: base64url' do
    specify 'variable length' do
      expect(parse('Z..90')).to eq(1..90)
    end
  end
end
