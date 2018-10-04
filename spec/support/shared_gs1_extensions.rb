RSpec.shared_examples_for 'a GS1 date' do
  include_examples 'GS1 date validations'

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

RSpec.shared_examples_for 'a GS1 GTIN' do
  lengths = [8, 12, 13, 14]

  include_examples 'GS1 length validations', lengths: lengths
  include_examples 'GS1 check digit validations'

  describe '#to_s' do
    subject { record.to_s }

    let(:record) { described_class.new(nil) }

    it 'calls to_gtin_14' do
      allow(record).to receive(:to_gtin_14)

      subject

      expect(record).to have_received(:to_gtin_14)
    end
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
end

RSpec.shared_examples_for 'a GS1 string' do |options|
  include_examples 'GS1 length validations', options
end
