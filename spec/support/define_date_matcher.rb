RSpec::Matchers.define :define_date do
  match do
    actual_allowed == {}
  end

  failure_message do |actual|
    "expected that #{actual} would define date it didn't"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not define date but it did"
  end

  def actual_allowed
    actual.definitions[:date]
  end
end
