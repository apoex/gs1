RSpec.describe GS1::SerialNumber do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::SERIAL) }
  end

  it_behaves_like 'a GS1 string', allowed_lengths: 1..20
end
