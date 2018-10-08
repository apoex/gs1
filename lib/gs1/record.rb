module GS1
  # Base class for a GS1 record.
  #
  class Record
    include Definitions
    include Validations

    attr_reader :data

    def initialize(data)
      super
      @data = data
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
  end
end
