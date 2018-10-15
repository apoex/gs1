RSpec.describe GS1::Validations do
  module GS1
    class ValidationDummy < Record
      define :check_digit
      define :date
      define :length
    end
  end

  let(:record) { GS1::ValidationDummy.new(nil) }

  describe '#valid?' do
    before do
      allow(record).to receive(:validate_check_digit)
      allow(record).to receive(:validate_date)
      allow(record).to receive(:validate_length)
    end

    it 'calls validations' do
      record.valid?

      expect(record).to have_received(:validate_check_digit)
      expect(record).to have_received(:validate_date)
      expect(record).to have_received(:validate_length)
    end
  end
end
