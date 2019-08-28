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
              errors << Error.new(:base, attribute_name, :already_defined)
            end

            errors << Error.new(:base, attribute_name, :unknown) unless record
          end
        end
      end
    end
  end
end
