RSpec.describe GS1::ExpirationDate do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::USE_BY) }
  end

  it_behaves_like 'a GS1 date'

  describe '#to_date' do
    subject { expiration_date.to_date }

    let(:expiration_date) { described_class.new(date_string) }

    context 'when YYMMDD format' do
      let(:date_string) { '201230' }

      it 'returns exact date' do
        is_expected.to eq(Date.new(2020, 12, 30))
      end
    end

    context 'when YYMM00 (month-based expiry) format' do
      let(:date_string) { '201200' }

      it 'returns last day in same month' do
        is_expected.to eq(Date.new(2020, 12, 31))
      end
    end

    context 'when unknown format' do
      let(:date_string) { '201232' }

      it 'returns nil' do
        is_expected.to be_nil
      end
    end
  end
end
