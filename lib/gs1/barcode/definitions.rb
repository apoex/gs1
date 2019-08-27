module GS1
  module Barcode
    # Module for handling definitions.
    #
    module Definitions
      def self.included(base)
        base.extend ClassMethods
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

        def record_names
          @records.map(&:underscore_name)
        end
      end
    end
  end
end
