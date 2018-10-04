RSpec.describe GS1::GTIN do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::GTIN) }
  end

  it_behaves_like 'a GS1 GTIN'
end
