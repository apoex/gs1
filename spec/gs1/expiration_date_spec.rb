RSpec.describe GS1::ExpirationDate do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::USE_BY) }
  end

  it_behaves_like 'a GS1 date (month based)'
end
