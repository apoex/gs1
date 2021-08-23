RSpec.describe GS1::CheckDigitCalculator do
  let(:check_digit) { described_class.new(sequence) }
  let(:sequence) { '629104150021' }

  describe '#initialize' do
    subject { check_digit }

    context 'when valid length' do
      it 'does not fail' do
        expect { subject }.not_to raise_error
      end
    end

    context 'when invalid length' do
      let(:sequence) { '123' }

      it 'fails' do
        expect { subject }.to raise_error(ArgumentError, 'Invalid length')
      end
    end
  end

  describe '.from_sequence' do
    subject { described_class.from_sequence(sequence) }

    before do
      expect(described_class).to receive(:new).with(sequence).and_return(check_digit)
      allow(check_digit).to receive(:check_digit)
    end

    it 'calls instance method' do
      subject

      expect(check_digit).to have_received(:check_digit)
    end
  end

  describe '.with_sequence' do
    subject { described_class.with_sequence(sequence) }

    before do
      expect(described_class).to receive(:new).with(sequence).and_return(check_digit)
      allow(check_digit).to receive(:calculate_sequence_with_digit)
    end

    it 'calls instance method' do
      subject

      expect(check_digit).to have_received(:calculate_sequence_with_digit)
    end
  end

  describe '#check_digit' do
    subject { check_digit.check_digit }

    it 'calculates correct check digit' do
      is_expected.to eq('3')
    end

    context 'GTIN-12 example' do
      let(:sequence) { '61414121022' }

      it 'calculates correct check digit' do
        is_expected.to eq('0')
      end
    end

    context 'GTIN-13 example' do
      let(:sequence) { '735005385001' }

      it 'calculates correct check digit' do
        is_expected.to eq('9')
      end
    end

    context 'GSIN example' do
      let(:sequence) { '7350066493304104' }

      it 'calculates correct check digit' do
        is_expected.to eq('3')
      end
    end

    context 'SSCC example' do
      let(:sequence) { '87350066493304104' }

      it 'calculates correct check digit' do
        is_expected.to eq('9')
      end
    end
  end

  describe '#calculate_sequence_with_digit' do
    subject { check_digit.calculate_sequence_with_digit }

    before { expect(check_digit).to receive(:check_digit).and_return('3') }

    it 'returns original sequence with calculated digit' do
      is_expected.to eq("#{sequence}3")
    end
  end
end
