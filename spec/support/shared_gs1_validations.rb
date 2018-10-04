RSpec.shared_examples_for 'GS1 check digit validations' do
  describe 'validations' do
    let(:record) { described_class.new(data) }
    let(:data) { '106141411234567891' }

    before do
      allow(GS1::CheckDigit).to receive(:with_sequence).with(data[0..-2]).and_return(calculated_sequence)
      record.validate_check_digit
    end

    context 'when check digit matches data' do
      let(:calculated_sequence) { '106141411234567891' }

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
end

RSpec.shared_examples_for 'GS1 date validations' do
  describe 'validations' do
    let(:record) { described_class.new(data) }

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
end

RSpec.shared_examples_for 'GS1 length validations' do |options|
  describe 'validations' do
    lengths = [options[:lengths].to_a].flatten.sort

    edge_case_under = lengths.first - 1
    edge_case_over = lengths.last + 1

    let(:record) { described_class.new(data) }

    before { record.validate_length }

    if edge_case_under >= 0
      context "when data is #{edge_case_under} characters long" do
        let(:data) { '1' * edge_case_under }

        it 'has invalid length error' do
          expect(record.errors).to eq(['Invalid length'])
        end
      end
    end

    lengths.each do |length|
      context "when data is #{length} characters long" do
        let(:data) { '1' * length }

        it 'has no errors' do
          expect(record.errors).to eq([])
        end
      end
    end

    context "when data is #{edge_case_over} characters long" do
      let(:data) { '1' * edge_case_over }

      it 'has invalid length error' do
        expect(record.errors).to eq(['Invalid length'])
      end
    end
  end
end
