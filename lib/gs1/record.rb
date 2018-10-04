module GS1
  # Base class for a GS1 record.
  #
  class Record
    attr_reader :data, :errors

    def initialize(data)
      @data = data
      @errors = []
    end

    def self.valid_data?(data)
      new(data).valid?
    end

    singleton_class.send(:attr_reader, :descendants)
    @descendants = []

    class << self
      def inherited(subclass)
        descendants << subclass
      end

      def ai
        self::AI
      end
    end

    def ai
      self.class.ai
    end

    def to_s
      data&.to_s
    end

    def to_ai
      "#{ai}#{data}"
    end

    def ==(other)
      self.class == other.class &&
        to_s == other.to_s
    end

    def valid?
      errors.clear

      validate

      errors.empty?
    end

    protected

    def validate
      raise NotImplementedError, 'Implement #validate'
    end
  end
end
