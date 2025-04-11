# GS1 module.
#
module GS1
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      if block_given?
        yield configuration
      else
        configuration
      end
    end
  end

  # Configuration holds custom configuration parameters.
  #
  class Configuration
    attr_accessor :company_prefix, :ignore_extra_barcode_elements
    attr_writer :barcode_separator

    def initialize
      @ignore_extra_barcode_elements = true
    end

    def barcode_separator
      @barcode_separator || GS1::Barcode::DEFAULT_SEPARATOR
    end
  end

  def self.ai_classes
    @ai_classes ||= begin
      GeneratedAIClasses.ai_classes
      # sort to get non-generated classes first
      ai_classes = GS1::Record.descendants.sort_by { _1.generated ? 1 : 0 }
      ai_classes.each_with_object({}) do |klass, hash|
        hash[klass.ai] ||= klass
      end
    end
  end

  module AIDCMarketingLevels
    ALL = [MINIMUM = 1,
           ENHANCED = 2,
           HIGHEST = 3].freeze
  end
end

require 'gs1/version'

require 'gs1/ai'
require 'gs1/check_digit_calculator'
require 'gs1/extensions'
require 'gs1/definitions'
require 'gs1/validations'

require 'gs1/record'
require 'gs1/generated_ai_classes'
require 'gs1/batch'
require 'gs1/content'
require 'gs1/expiration_date'
require 'gs1/gtin'
require 'gs1/serial_number'
require 'gs1/sscc'

require 'gs1/barcode'
