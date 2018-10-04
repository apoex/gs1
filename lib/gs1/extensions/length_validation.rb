module GS1
  module Extensions
    # Ensures correct length validation.
    #
    module LengthValidation
      def self.included(base)
        base.extend         ClassMethods
        base.send :include, InstanceMethods
      end

      # Implements lengths class variable to classes including LengthValidation
      # module.
      #
      module ClassMethods
        attr_reader :lengths

        def valid_lengths(lengths = nil)
          @lengths = lengths
        end
      end

      # Implements lengths instance methods to classes including LengthValidation
      # module.
      #
      module InstanceMethods
        def valid_length?
          self.class.lengths.to_a.include?(data&.size)
        end

        def validate_length
          errors << 'Invalid length' unless valid_length?
        end
      end
    end
  end
end
