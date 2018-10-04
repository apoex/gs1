require 'gs1/version'

require 'gs1/ai'
require 'gs1/check_digit_calculator'
require 'gs1/extensions'
require 'gs1/definitions'
require 'gs1/validations'

require 'gs1/record'
require 'gs1/batch'
require 'gs1/content'
require 'gs1/expiration_date'
require 'gs1/gtin'
require 'gs1/serial_number'
require 'gs1/sscc'

require 'gs1/barcode'

# GS1 module.
#
module GS1
  class << self
    def configure
      @configuration ||= Configuration.new

      yield @configuration
    end

    attr_reader :configuration
  end

  # Configuration holds custom configuration parameters.
  #
  class Configuration
    attr_accessor :company_prefix
  end

  AI_CLASSES = GS1::Record.descendants.each_with_object({}) do |klass, hash|
    hash[klass.ai] = klass
  end

  module AIDCMarketingLevels
    ALL = [MINIMUM = 1,
           ENHANCED = 2,
           HIGHEST = 3].freeze
  end
end
