require 'gs1/version'

require 'gs1/ai'

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
end
