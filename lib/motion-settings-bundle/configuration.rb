module Motion
  module SettingsBundle
    class Configuration
      attr_reader :preferences, :children

      def initialize(&block)
        @preferences = []
        @children = {}
        block.call(self)
      end

      def text(title, options = {})
        preference(title, "PSTextFieldSpecifier", options, {
          "IsSecure"               => options[:secure]             || false,
          "KeyboardType"           => options[:keyboard]           || "Alphabet",
          "AutocapitalizationType" => options[:autocapitalization] || "Sentences",
          "AutocorrectionType"     => options[:autocorrection]     || "Default"
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

      def group(title, options = {})
        group = {"Title" => title, "Type" => "PSGroupSpecifier"}
        group["FooterText"] = options[:footer] if options[:footer]
        @preferences << group
      end

      def child(title, options = {}, &block)
        @preferences << {"Title" => title, "File" => title, "Type" => "PSChildPaneSpecifier"}.merge(options)
        @children[title] = Configuration.new(&block)
      end

      private

      def preference(title, type, options, extras = {})
        @preferences << {"Title" => title, "Key" => options[:key], "DefaultValue" => options[:default], "Type" => type}.merge(extras)
      end
    end
  end
end
