class NormalizationHelper
  class << self
    def normalize_multiple_option(option_value)
      case option_value
      when Range then option_value.to_a
      when Array then option_value
      else [option_value]
      end
    end
  end
end
