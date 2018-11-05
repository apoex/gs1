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

      def underscore_name
        name.split('::')
            .last
            .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
            .gsub(/([a-z\d])([A-Z])/, '\1_\2')
            .tr('-', '_')
            .downcase
            .to_sym
      end
    end

    def ai
      self.class.ai
    end

    def to_s
      data && data.to_s
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
