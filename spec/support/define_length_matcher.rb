RSpec::Matchers.define :define_allowed_length do |expected|
  match do
    return actual_allowed unless expected

    normalized_expected = NormalizationHelper.normalize_multiple_option(expected)

    actual_allowed == normalized_expected
  end

  failure_message do |actual|
    if expected
      "expected that #{actual} would define allowed length #{expected.inspect} but defined #{actual_allowed.inspect}"
    else
      "expected that #{actual} would define allowed length but it didn't"
    end
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not define allowed length to #{expected} but defined #{actual_allowed}"
  end

  def actual_allowed
    actual.definitions[:length][:allowed]
  end
end

RSpec::Matchers.define :define_barcode_length do |expected|
  match do
    return actual_barcode unless expected

    actual_barcode == expected
  end

  failure_message do |actual|
    "expected that #{actual} would define barcode length to #{expected} but defined #{actual_barcode}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not define barcode length to #{expected} but defined #{actual_barcode}"
  end

  def actual_barcode
    actual.definitions[:length][:barcode]
  end
end

RSpec::Matchers.define :define_max_barcode_length do |expected|
  match do
    return actual_max_barcode unless expected

    actual_max_barcode == expected
  end

  failure_message do |actual|
    "expected that #{actual} would define max barcode length to #{expected} but defined #{actual_max_barcode}"
  end

  failure_message_when_negated do |actual|
    "expected that #{actual} would not define allowed length to #{expected} but defined #{actual_max_barcode}"
  end

  def actual_max_barcode
    actual.definitions[:length][:max_barcode]
  end
end
