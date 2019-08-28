module GS1
  module Barcode
    # Module for handling definitions.
    #
    module Definitions
      def self.included(base)
        base.extend ClassMethods
        base.send :include, InstanceMethods
      end

      # Adding defintion class methods.
      #
      module ClassMethods
        attr_reader :records

        def define_records(*records)
          @records ||= []
          @records = records

          records.each do |record|
            attr_reader record.underscore_name
          end
        end
      end

      # Adding defintion instance methods.
      #
      module InstanceMethods
        def validate_record_attribute_name(attribute_name)
          self.class.records.find { |r| r.underscore_name == attribute_name }.tap do |record|
            if instance_variable_get("@#{attribute_name}")
              errors[attribute_name] << Error.new(:already_defined, persistent: true)
            end

            errors[attribute_name] << Error.new(:unknown_attribute, persistent: true) unless record
          end
        end
      end
    end
  end
end
