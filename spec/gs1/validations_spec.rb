RSpec.describe GS1::Validations do
  module GS1
    class Dummy < Record
      validate :check_digit
      validate :date
      validate :length
    end
  end

  let(:record) { GS1::Dummy.new(nil) }

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
