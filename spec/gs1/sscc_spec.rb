RSpec.describe GS1::SSCC do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::SSCC) }
  end

  describe 'validations' do
    include_examples 'GS1 check digit validations'
    include_examples 'GS1 length validations', allowed_lengths: [18]
  end
end
