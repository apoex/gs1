# frozen_string_literal: true

RSpec.describe GS1::Definitions do
  class GoodTestClass
    include GS1::Definitions

    define :length, barcode: 5
  end

  class BadTestClass
    include GS1::Definitions

    define :date
  end

  describe '.barcode_length' do
    subject { test_class.barcode_length }

    context 'with a well defined length' do
      let(:test_class) { GoodTestClass }
      it 'is readable' do
        expect(subject).to eq 5
      end
    end

    context 'with an undefined length' do
      let(:test_class) { BadTestClass }

      it 'raises an error' do
        expect { subject }.to raise_error(GS1::Definitions::MissingLengthDefinition)
      end
    end
  end
end
