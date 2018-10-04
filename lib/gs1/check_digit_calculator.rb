module GS1
  # GS1 check digit calculation
  #
  # Implementation of: http://www.gs1.org/how-calculate-check-digit-manually
  # Notice! This class does not validate the format of the given sequence,
  # only the length.
  #
  class CheckDigitCalculator
    MULTIPLIER_ARRAY = [3, 1] * 9
    VALID_LENGTHS = [7, 11, 12, 13, 17].freeze

    def initialize(sequence)
      @sequence = sequence
      @reverse_sequence = sequence.chars.reverse

      raise ArgumentError, 'Invalid length' unless VALID_LENGTHS.include?(sequence.size)
    end

    def self.from_sequence(sequence)
      new(sequence).check_digit
    end

    def self.with_sequence(sequence)
      new(sequence).calculate_sequence_with_digit
    end

    def check_digit
      sub_from_nearest_higher_ten.to_s
    end

    def calculate_sequence_with_digit
      sequence + check_digit
    end

    private

    attr_reader :sequence, :reverse_sequence

    def multiplied_sequence
      @multiplied_sequence ||= reverse_sequence.each_with_index.map do |digit, idx|
        digit.to_i * MULTIPLIER_ARRAY[idx]
      end
    end

    def sub_from_nearest_higher_ten
      (10 - (multiplied_sequence.inject(:+) % 10)) % 10
    end
  end
end
