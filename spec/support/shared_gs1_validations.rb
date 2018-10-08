RSpec.shared_examples_for 'GS1 check digit validations' do
  describe 'GS1 check digit validations' do
    let(:record) { described_class.new(data) }
    let(:data) { '106141411234567891' }
    let(:calculated_sequence) { nil }

    subject { record.validate_check_digit }

    context 'when valid length' do
      before do
        allow(GS1::CheckDigitCalculator).to receive(:with_sequence).with(data[0..-2]).and_return(calculated_sequence)
        subject
      end

      context 'when check digit matches data' do
        let(:calculated_sequence) { data }

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

    context 'when invalid length' do
      let(:data) { '106' }

      before do
        allow(GS1::CheckDigitCalculator).to receive(:with_sequence).and_raise(ArgumentError)
        subject
      end

      it 'has invalid check digit error' do
        expect(record.errors).to eq(['Check digit mismatch'])
      end
    end
  end
end

RSpec.shared_examples_for 'GS1 date validations' do
  describe 'GS1 date validations' do
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
  describe 'GS1 length validations' do
    expected_allowed_lengths = [options[:allowed_lengths].to_a].flatten.sort

    expected_edge_case_one_under = expected_allowed_lengths.first - 1
    expected_edge_case_one_over = expected_allowed_lengths.last + 1

    let(:record) { described_class.new(data) }

    before { record.validate_length }

    if expected_edge_case_one_under >= 0
      context "when data is #{expected_edge_case_one_under} characters long" do
        let(:data) { '1' * expected_edge_case_one_under }

        it 'has invalid length error' do
          expect(record.errors).to eq(['Invalid length'])
        end
      end
    end

    expected_allowed_lengths.each do |expected_allowed_length|
      context "when data is #{expected_allowed_length} characters long" do
        let(:data) { '1' * expected_allowed_length }

        it 'has no errors' do
          expect(record.errors).to eq([])
        end
      end
    end

    context "when data is #{expected_edge_case_one_over} characters long" do
      let(:data) { '1' * expected_edge_case_one_over }

      it 'has invalid length error' do
        expect(record.errors).to eq(['Invalid length'])
      end
    end
  end
end
