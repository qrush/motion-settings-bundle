module Motion
  module Settings
    class Configuration
      attr_reader :preferences

      def initialize(&block)
        @preferences = []
        block.call(self)
      end

      def text(title, options = {})
        preference(title, "PSTextFieldSpecifier", options, {
          "IsSecure"               => false,
          "KeyboardType"           => "Alphabet",
          "AutoCapitalizationType" => "Sentences",
          "AutocorrectionType"     => "Default"
        })
      end

      def title(title, options = {})
        preference(title, "PSTitleValueSpecifier", options)
      end

      def toggle(title, options = {})
        preference(title, "PSToggleSwitchSpecifier", options, {
          "TrueValue"  => true,
          "FalseValue" => false
        })
      end

      def slider(title, options = {})
        preference(title, "PSSliderSpecifier", options, {
          "MinimumValue" => options[:min],
          "MaximumValue" => options[:max]
        })
      end

      def options(title, options = {})
      end

      private

      def preference(title, type, options, extras = {})
        @preferences << {"Title" => title, "Key" => options[:key], "DefaultValue" => options[:default], "Type" => type}.merge(extras)
      end
    end
  end
end
