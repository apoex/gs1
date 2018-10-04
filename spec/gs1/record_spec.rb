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

    before { allow(data).to receive(:to_s) }

    it 'calls #to_s on data' do
      subject

      expect(data).to have_received(:to_s)
    end
  end

  describe '#to_ai' do
    subject { record.to_ai }

    before do
      allow(record).to receive(:ai).and_return('AI')
      allow(record).to receive(:data).and_return('DATA')
    end

    it 'concatinates #ai and #data' do
      is_expected.to eq('AIDATA')
    end
  end

  describe '#==' do
    subject { record == other_record }

    module GS1
      class Dummy < Record; end
      class SuperDummy < Record; end
    end

    let(:record) { GS1::Dummy.new(data) }
    let(:data) { 'data' }

    context 'when same class' do
      let(:other_record) { GS1::Dummy.new(other_data) }

      context 'with same data' do
        let(:other_data) { data }

        it 'is equal' do
          is_expected.to eq(true)
        end
      end

      context 'with different data' do
        let(:other_data) { 'not data' }

        it 'is equal' do
          is_expected.to eq(false)
        end
      end
    end

    context 'when different class' do
      let(:other_record) { GS1::SuperDummy.new(other_data) }

      context 'with same data' do
        let(:other_data) { data }

        it 'is not equal' do
          is_expected.to eq(false)
        end
      end

      context 'with different data' do
        let(:other_data) { 'not data' }

        it 'is not equal' do
          is_expected.to eq(false)
        end
      end
    end
  end
end
