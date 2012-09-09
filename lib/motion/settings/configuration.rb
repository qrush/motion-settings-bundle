module Motion
  module Settings
    class Configuration
      attr_reader :preferences

      def initialize(&block)
        @preferences = []
        block.call(self)
      end

      def text(title, options = {})
        @preferences << preference(title, "PSTextFieldSpecifier", options).merge({
          "IsSecure"               => false,
          "KeyboardType"           => "Alphabet",
          "AutoCapitalizationType" => "Sentences",
          "AutocorrectionType"     => "Default"
        })
      end

      def title(title, options = {})
        @preferences << preference(title, "PSTitleValueSpecifier", options)
      end

      def toggle(title, options = {})
        puts "Toggle: #{title}"
      end

      def slider(title, options = {})
        puts "Slider: #{title}"
      end

      def group(title, options = {})
        puts "Group: #{title}"
      end

      private

      def preference(title, type, options = {})
        {"Title" => title, "Key" => options[:key], "DefaultValue" => options[:default], "Type" => type}
      end
    end
  end
end
