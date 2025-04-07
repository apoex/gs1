RSpec.shared_examples_for 'a GS1 date' do
  describe 'definitions' do
    subject { described_class }

    it { is_expected.to define_date }
    it { is_expected.to define_allowed_length(6) }
    it { is_expected.to define_barcode_length(6) }
    it { is_expected.to define_max_barcode_length(6) }
  end

  describe '#to_s' do
    subject { record.to_s }

    let(:record) { described_class.new(data) }

    context 'when data is a date' do
      let(:data) { Date.new(2018, 10, 5) }

      it 'returns \'%y%m%d\' format' do
        is_expected.to eq('181005')
      end
    end

    context 'when data is a string' do
      let(:data) { '181005' }

      it 'returns \'%y%m%d\' format' do
        is_expected.to eq('181005')
      end
    end
  end

  describe '#to_date' do
    subject { record.to_date }

    let(:record) { described_class.new(data) }

    context 'when data is a date' do
      let(:data) { Date.new(2018, 10, 5) }

      it 'returns \'%y%m%d\' format' do
        is_expected.to eq(Date.new(2018, 10, 5))
      end
    end

    context 'when data is a string' do
      let(:data) { '181005' }

      it 'returns \'%y%m%d\' format' do
        is_expected.to eq(Date.new(2018, 10, 5))
      end
    end
  end
end

RSpec.shared_examples_for 'a GS1 date (month based)' do
  describe 'definitions' do
    subject { described_class }

    it { is_expected.to define_date_month_based }
    it { is_expected.to define_allowed_length(6) }
    it { is_expected.to define_barcode_length(6) }
    it { is_expected.to define_max_barcode_length(6) }
  end

  describe '#to_s' do
    subject { record.to_s }

    let(:record) { described_class.new(data) }

    context 'when data is a date' do
      let(:data) { Date.new(2018, 10, 5) }

      it 'returns \'%y%m%d\' format' do
        is_expected.to eq('181005')
      end
    end

    context 'when data is a string' do
      let(:data) { '181005' }

      it 'returns \'%y%m%d\' format' do
        is_expected.to eq('181005')
      end
    end
  end

  describe '#to_date' do
    subject { expiration_date.to_date }

    let(:expiration_date) { described_class.new(data) }

    context 'when YYMMDD format' do
      let(:data) { '201230' }

      it 'returns exact date' do
        is_expected.to eq(Date.new(2020, 12, 30))
      end
    end

    context 'when YYMM00 (month-based expiry) format' do
      let(:data) { '201200' }

      it 'returns last day in same month' do
        is_expected.to eq(Date.new(2020, 12, 31))
      end
    end

    context 'when unknown format' do
      let(:data) { '201232' }

      it 'returns nil' do
        is_expected.to be_nil
      end
    end
  end
end

RSpec.shared_examples_for 'a GS1 GTIN' do
  lengths = [8, 12, 13, 14]

  describe 'definitions' do
    subject { described_class }

    it { is_expected.to define_allowed_length(lengths) }
    it { is_expected.to define_barcode_length(14) }
    it { is_expected.to define_max_barcode_length(14) }
  end

  lengths.each do |length|
    describe "#to_gtin_#{length}" do
      subject { record.public_send("to_gtin_#{length}") }

      let(:record) { described_class.new(data) }
      let(:data) { '123' }

      it "prepends zeros so the total length is #{length}" do
        is_expected.to eq("#{'0' * (length - data.size)}123")
      end

      context 'when no data' do
        let(:data) { nil }

        it "returns #{length} zeros" do
          is_expected.to eq('0' * length)
        end
      end
    end
  end

  describe '#to_s' do
    # rubocop:disable Naming/VariableNumber
    subject { record.to_s }

    before do
      allow(record).to receive(:to_gtin_14)
    end

    let(:record) { described_class.new(data) }
    let(:data) { 'DATA' }

    context 'when nil' do
      let(:data) { nil }

      it 'calls to_gtin_14' do
        expect(subject).to be_nil

        expect(record).not_to have_received(:to_gtin_14)
      end
    end

    it 'calls to_gtin_14' do
      subject

      expect(record).to have_received(:to_gtin_14)
    end

    # rubocop:enable Naming/VariableNumber
  end
end
