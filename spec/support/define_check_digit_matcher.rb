RSpec::Matchers.define :define_check_digit do
  match do
    actual_allowed == {}
  end

  failure_message do |actual|
    "expected that #{actual} would define check digit it didn't"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not define check digit but it did"
  end

  def actual_allowed
    actual.definitions[:check_digit]
  end
end
