module GS1
  module Barcode
    # A segment of a barcode. Retrives a single segment and keeps the rest.
    #
    class Segment
      attr_reader :data, :separator

      def initialize(data, separator: GS1.configuration.barcode_separator)
        @data = data.chars
        @separator = separator
      end

      def to_params
        return [] unless record

        [record.underscore_name, record_data]
      end

      # Fetch the two first characters (interpreted as AI) from the remaining
      # data and try to find record class. If no record class was found, fetch
      # a third character and try again, and then finally a forth, as no AI
      # currently have more then 4 characters.
      def record
        @record ||= process_ai_variants(2) ||
                    process_ai_variants(1) ||
                    process_ai_variants(1)
      end

      def record_data
        return unless record

        @record_data ||= _record_data
      end

      def rest
        record_data # Trigger segment retrieval

        @data.join
      end

      def valid?
        errors.clear

        validate

        errors.empty?
      end

      def validate
        if record
          errors << "Unable to retrieve data to #{record}" unless record_data
        else
          errors << "Unable to retrieve record from application identifier(s) #{ai_variants.join(', ')}"
        end
      end

      def validate!
        return true if valid?

        raise InvalidTokenError, errors.join(', ')
      end

      def errors
        @errors ||= []
      end

      private

      def ai_variants
        @ai_variants ||= []
      end

      def process_ai_variants(shifts)
        return unless can_shift_ai_data?(shifts)

        ai_variants << ai_variants.last.to_s + data.shift(shifts).join

        AI_CLASSES[ai_variants.last]
      end

      def can_shift_ai_data?(shifts)
        data.size >= shifts
      end

      def _record_data
        shift_barcode_length ||
          shift_separator_length ||
          shift_max_barcode_length
      end

      # Record has a fixed barcode length
      def shift_barcode_length
        return unless record.barcode_length

        shift_fixed_length(record.barcode_length)
      end

      # Record has a variable barcode length
      def shift_separator_length
        separator_index = data.find_index(separator)

        return unless separator_index && separator_index <= record.barcode_max_length

        shift_fixed_length(separator_index).tap do
          data.shift # Shift separator character
        end
      end

      def shift_max_barcode_length
        shift_fixed_length(record.barcode_max_length)
      end

      def shift_fixed_length(shifts)
        normalized_shifts = [data.size, shifts].min

        return unless can_shift_record_data?(normalized_shifts)

        data.shift(normalized_shifts).join
      end

      def can_shift_record_data?(shifts)
        data.size >= shifts && record.allowed_lengths.include?(shifts)
      end
    end
  end
end
