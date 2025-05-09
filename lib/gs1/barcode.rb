require 'gs1/barcode/attribute_validator'
require 'gs1/barcode/attribute_validators/record_validator'
require 'gs1/barcode/attribute_validators/ignoring_record_validator'
require 'gs1/barcode/definitions'
require 'gs1/barcode/error'
require 'gs1/barcode/errors'

require 'gs1/barcode/base'
require 'gs1/barcode/healthcare'
require 'gs1/barcode/segment'
require 'gs1/barcode/tokenizer'

module GS1
  module Barcode
    DEFAULT_SEPARATOR = "\u001E".freeze

    class InvalidTokenError < StandardError; end
  end
end
