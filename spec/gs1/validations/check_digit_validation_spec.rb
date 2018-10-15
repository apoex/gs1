require 'spec_helper'

RSpec.describe GS1::Validations::CheckDigitValidation do
  class ValidationCheckDigitDummy
    include GS1::Validations::CheckDigitValidation

    attr_reader :data, :errors

    def initialize(data)
      @data = data
      @errors = []
    end
  end

  let(:record) { ValidationCheckDigitDummy.new(data) }
  let(:data) { '106141411234567891' }
  let(:calculated_sequence) { nil }

  subject { record.validate_check_digit }

  context 'when valid length' do
    before do
      allow(GS1::CheckDigitCalculator).to receive(:with_sequence).with(data[0..-2]).and_return(calculated_sequence)
      subject
    end

    context 'when check digit matches data' do
      let(:calculated_sequence) { data }

      it 'has no errors' do
        expect(record.errors).to eq([])
      end
    end

    context 'when not check digit matches data' do
      let(:calculated_sequence) { '106141411234567893' }

      it 'has invalid check digit error' do
        expect(record.errors).to eq(['Check digit mismatch'])
      end
    end
  end

  context 'when invalid length' do
    let(:data) { '106' }

    before do
      allow(GS1::CheckDigitCalculator).to receive(:with_sequence).and_raise(ArgumentError)
      subject
    end

    it 'has invalid check digit error' do
      expect(record.errors).to eq(['Check digit mismatch'])
    end
  end
end
