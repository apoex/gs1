require 'gs1/validations/check_digit_validation'
require 'gs1/validations/date_validation'
require 'gs1/validations/length_validation'

module GS1
  # Module for handling validations.
  #
  module Validations
    def self.included(base)
      base.extend ClassMethods
      base.send :include, InstanceMethods
      base.send :include, CheckDigitValidation
      base.send :include, DateValidation
      base.send :include, LengthValidation
    end

    # Adding validation class methods.
    #
    module ClassMethods
      def valid_data?(data)
        new(data).valid?
      end
    end

    # Adding validation instance methods.
    #
    module InstanceMethods
      attr_reader :errors

      def initialize(*)
        @errors = []
      end

      def valid?
        errors.clear

        validate

        errors.empty?
      end

      def validate
        self.class.definitions.each_key do |definition|
          public_send("validate_#{definition}")
        end
      end
    end
  end
end
