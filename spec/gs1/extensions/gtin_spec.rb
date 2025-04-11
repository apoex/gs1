require 'spec_helper'

RSpec.describe GS1::Extensions::GTIN do
  it_behaves_like 'a GS1 GTIN' do
    let(:described_class) do
      Class.new(GS1::Record) do
        include GS1::Extensions::GTIN

        self::AI = SecureRandom.uuid
      end
    end
  end
end
