RSpec.describe GS1::Record do
  let(:record) { described_class.new(data) }
  let(:data) { '123' }

  describe '.valid_data?' do
    subject { described_class.valid_data?(data) }

    it 'calls #valid?' do
      expect(described_class).to receive(:new).and_return(record)
      allow(record).to receive(:valid?)

      subject

      expect(record).to have_received(:valid?)
    end
  end

  describe '#ai' do
    subject { record.ai }

    before { allow(described_class).to receive(:ai) }

    it 'calls .ai' do
      subject

      expect(described_class).to have_received(:ai)
    end
  end

  describe '#to_s' do
    subject { record.to_s }

    context 'with data present' do
      before { allow(data).to receive(:to_s) }

      it 'calls #to_s on data' do
        subject

        expect(data).to have_received(:to_s)
      end
    end

    context 'without data' do
      let(:data) { nil }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#to_ai' do
    subject { record.to_ai }

    let(:ai) { 'AI' }
    let(:data) { 'DATA' }

    before do
      allow(record).to receive(:ai).and_return(ai)
    end

    it 'concatinates #ai and #to_s' do
      is_expected.to eq('AIDATA')
    end

    context 'when no data' do
      let(:data) { nil }

      it { is_expected.to be_nil }
    end
  end

  describe '#==' do
    subject { record }

    let(:record_dummy) do
      Class.new(GS1::Record) { self::AI = SecureRandom.uuid }
    end

    let(:record_super_dummy) do
      Class.new(GS1::Record) { self::AI = SecureRandom.uuid }
    end

    let(:record) { record_dummy.new(data) }
    let(:data) { 'data' }

    context 'when same class' do
      let(:other_record) { record_dummy.new(other_data) }

      context 'with same data' do
        let(:other_data) { data.dup }

        it 'is equal' do
          expect(subject).to eq(other_record)
        end
      end

      context 'with different data' do
        let(:other_data) { 'not data' }

        it 'is not equal' do
          expect(subject).not_to eq(other_record)
        end
      end
    end

    context 'when different class' do
      let(:other_record) { record_super_dummy.new(other_data) }

      context 'with same data' do
        let(:other_data) { data }

        it 'is not equal' do
          expect(subject).not_to eq(other_record)
        end
      end

      context 'with different data' do
        let(:other_data) { 'not data' }

        it 'is not equal' do
          expect(subject).not_to eq(other_record)
        end
      end
    end
  end
end
