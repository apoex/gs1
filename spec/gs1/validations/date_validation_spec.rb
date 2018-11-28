RSpec.describe GS1::Validations::DateValidation do
  class ValidationDateDummy
    include GS1::Validations::DateValidation

    attr_reader :data, :errors

    def initialize(data)
      @data = data
      @errors = []
    end
  end

  let(:record) { ValidationDateDummy.new(data) }

  before { record.validate_date }

  context 'when data is a date' do
    let(:data) { Date.today }

    it 'has no errors' do
      expect(record.errors).to eq([])
    end
  end

  context 'when data has a parsable date format' do
    let(:data) { '181005' }

    it 'has no errors' do
      expect(record.errors).to eq([])
    end
  end

  context 'when data has a parsable date format' do
    let(:data) { '181000' }

    it 'has no errors' do
      expect(record.errors).to eq([])
    end
  end

  context 'when data has not a parsable date format' do
    let(:data) { '123123' }

    it 'has invalid date error' do
      expect(record.errors).to eq(['Invalid date'])
    end
  end

  context 'when not data' do
    let(:data) { nil }

    it 'has invalid date error' do
      expect(record.errors).to eq(['Invalid date'])
    end
  end
end
