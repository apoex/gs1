RSpec.describe GS1::SSCC do
  describe 'application identifier' do
    subject { described_class::AI }

    it { is_expected.to eq(GS1::AI::SSCC) }
  end

  describe 'definitions' do
    subject { described_class }

    it { is_expected.to define_check_digit }
    it { is_expected.to define_allowed_length(18) }
  end
end
