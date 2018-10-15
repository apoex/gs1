RSpec.describe GS1::Validations::LengthValidation do
  class ValidationLengthDummy
    include GS1::Validations::LengthValidation

    attr_reader :data, :errors

    def initialize(data)
      @data = data
      @errors = []
    end
  end

  let(:record) { ValidationLengthDummy.new(data) }
  let(:expected_allowed_lengths) { [0] }
  let(:expected_barcode_length) { 0 }

  before do
    allow(ValidationLengthDummy).to receive(:allowed_lengths).and_return(expected_allowed_lengths)
    allow(ValidationLengthDummy).to receive(:barcode_length).and_return(expected_barcode_length)
    record.validate_length
  end

  describe 'allowed lengths' do
    let(:expected_allowed_lengths) { [4] }

    context 'when data is under character length definition' do
      let(:data) { '1' * (expected_allowed_lengths.first - 1) }

      it 'has invalid length error' do
        expect(record.errors).to eq(['Invalid length'])
      end
    end

    context 'when data is within character length definition' do
      let(:data) { '1' * expected_allowed_lengths.first }

      it 'has no errors' do
        expect(record.errors).to eq([])
      end
    end

    context 'when data is over character length definition' do
      let(:data) { '1' * (expected_allowed_lengths.last + 1) }

      it 'has invalid length error' do
        expect(record.errors).to eq(['Invalid length'])
      end
    end
  end

  describe 'barcode lengths' do
    let(:expected_barcode_length) { 5 }

    context 'when data is under character length definition' do
      let(:data) { '1' * (expected_barcode_length - 1) }

      it 'has invalid length error' do
        expect(record.errors).to eq(['Invalid length'])
      end
    end

    context 'when data is within character length definition' do
      let(:data) { '1' * expected_barcode_length }

      it 'has no errors' do
        expect(record.errors).to eq([])
      end
    end

    context 'when data is over character length definition' do
      let(:data) { '1' * (expected_barcode_length + 1) }

      it 'has invalid length error' do
        expect(record.errors).to eq(['Invalid length'])
      end
    end
  end
end
