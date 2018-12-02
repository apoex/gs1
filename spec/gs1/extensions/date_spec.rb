require 'spec_helper'

RSpec.describe GS1::Extensions::Date do
  class DateDummy < GS1::Record
    include GS1::Extensions::Date
  end

  it_behaves_like 'a GS1 date' do
    let(:described_class) { DateDummy }
  end
end
