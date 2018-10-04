RSpec.describe GS1::SSCC do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::SSCC) }
  end

  include_examples 'GS1 check digit validations'
  include_examples 'GS1 length validations', lengths: [18]
end
