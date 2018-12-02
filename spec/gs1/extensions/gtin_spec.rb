require 'spec_helper'

RSpec.describe GS1::Extensions::GTIN do
  class GTINDummy < GS1::Record
    include GS1::Extensions::GTIN
  end

  it_behaves_like 'a GS1 GTIN' do
    let(:described_class) { GTINDummy }
  end
end
