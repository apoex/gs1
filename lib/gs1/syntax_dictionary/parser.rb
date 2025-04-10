require 'gs1/syntax_dictionary/specification_parser'

module GS1
  module SyntaxDictionary
    # Parser for the GS1 syntax dictionary.
    #
    # The latest version of the syntax dictionary is available at:
    # https://ref.gs1.org/tools/gs1-barcode-syntax-resource/syntax-dictionary.
    #
    # The syntax dictionary has been copied to gs1-syntax-dictionary.txt. The
    # format of the syntax dictionary is available at the top of the dictionary.
    class Parser
      # Some generic String helpers.
      module StringHelpers
        refine String do
          def blank? = empty? || /\A[[:space:]]*\z/.match?(self)

          def comment? = start_with?('#')
        end
      end

      using StringHelpers

      # Corresponds to a single entry in the syntax dictionary.
      class Entry
        # @return [String] the application identifier
        attr_reader :ai

        # @return [Boolean] indicates if a separator is required or not
        attr_reader :separator_required

        # @return [Range<Integer>] the length of the AI
        attr_reader :length

        # @return [String] the title of the AI
        attr_reader :title

        # rubocop:disable Naming/MethodParameterName
        def initialize(ai:, separator_required:, length:, title:)
          # rubocop:enable Naming/MethodParameterName
          @ai = ai
          @separator_required = separator_required
          @length = length
          @title = title
        end
      end

      # @param data [String] the syntax dictionary data to parse
      def initialize(data)
        @data = data
      end

      # Parses the syntax dictionary data and returns a list of dictionary
      # entries.
      #
      # @return [Array<Entry>] a list of syntax dictionary entries
      def parse = entry_lines.flat_map { parse_line(_1) }

      private

      attr_reader :data

      def lines = @lines ||= data.split("\n")

      def entry_lines = @entry_lines ||= lines.reject { _1.comment? || _1.blank? }

      def columns(line_data)
        line_data.match(column_patterns.entry_rx)
                 &.named_captures
                 &.values_at(*%w[ais flags spec title]) or
          raise "Invalid entry format: #{line_data}"
      end

      def parse_line(line_data)
        ais, flags, specification, base_title = columns(line_data)

        parse_ais(ais, base_title).map do |(ai, title)|
          Entry.new(
            ai: ai,
            separator_required: separator_required?(flags),
            length: SpecificationParser.new(specification).parse,
            title: title
          )
        end
      end

      def parse_ais(ai_data, base_title)
        first, last = ai_data.split('-')
        last ||= first
        range = first..last
        range.map { [_1, build_title(range, base_title, _1)] }
      end

      def build_title(ai_range, base_title, current_ai)
        if ai_range.count == 1
          base_title || current_ai
        else
          base_title ? "#{base_title}_#{current_ai}" : current_ai
        end
      end

      def separator_required?(flags) = !flags.include?('*')

      def column_patterns = @column_patterns ||= ColumnPatterns.new

      # Patterns stolen from: https://github.com/gs1/gs1-syntax-engine/blob/f8b6345655fa9fa25ce1c5a11c5a317f9239529a/src/c-lib/build-embedded-ai-table.pl#L17-L100
      # The naming and extra indentation is to keep the code as close to the
      # original Perl code above.
      #
      # rubocop:disable Lint/DuplicateRegexpCharacterClassElement
      # rubocop:disable Style/RegexpLiteral
      class ColumnPatterns
        # rubocop:disable Metrics/MethodLength
        def entry_rx
          /
              ^
              (?<ais>#{ai_rng_rx})
              (
                  \s+
                  (?<flags>#{flags_rx})
              )?
              \s+
              (?<spec>#{spec_rx})
              (
                  \s+
                  (?<keyvals>
                      (#{keyval_rx}\s+)*
                      #{keyval_rx}
                  )
              )?
              (
                  \s+
                  \#
                  \s
                  (?<title>#{title_rx})
              )?
              \s*
              $
          /x
        end
        # rubocop:enable Metrics/MethodLength

        private

        def ai_rx
          /
              (
                  (0\d)
              |
                  ([1-9]\d{1,3})
              )
          /x
        end

        def ai_rng_rx = /#{ai_rx}(-#{ai_rx})?/

        def flags_rx
          /
              [
                  *?!"%&'()+,.:;<=>@\[_`{|}~
                  \$  \-  \/  \\  \]  \^
              ]+
          /x
        end

        def type_mand_rx
          /
              [XNYZ]
              (
                  ([1-9]\d?)
                  |
                  (\.\.[1-9]\d?)
              )
          /x
        end

        def type_opt_rx
          /
              \[#{type_mand_rx}\]
          /x
        end

        def type_rx
          /
              (
                  #{type_mand_rx}
                  |
                  #{type_opt_rx}
              )
          /x
        end

        def comp_rx
          /
              #{type_rx}
              (,\w+)*
          /x
        end

        def spec_rx
          /
              #{comp_rx}
              (\s+#{comp_rx})*
          /x
        end

        def keyval_rx
          /
              (
                  (\w+)
                  |
                  (\w+=\S+)
              )
          /x
        end

        def title_rx = /\S.*\S/
      end
      # rubocop:enable Lint/DuplicateRegexpCharacterClassElement
      # rubocop:enable Style/RegexpLiteral
    end
  end
end
