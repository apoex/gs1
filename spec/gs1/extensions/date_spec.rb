require 'spec_helper'

RSpec.describe GS1::Extensions::Date do
  it_behaves_like 'a GS1 date' do
    let(:described_class) do
      Class.new(GS1::Record) do
        include GS1::Extensions::Date

        self::AI = SecureRandom.uuid
      end
    end
  end
end
