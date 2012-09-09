module Motion
  module Settings
    class Configuration
      attr_reader :preferences

      def initialize(&block)
        @preferences = []
        block.call(self)
      end

      def text(title, options = {})
        puts "Text: #{title}"
      end

      def title(title, options = {})
        @preferences << {"Title" => title, "Key" => options[:key], "DefaultValue" => options[:default], "Type" => "PSTitleValueSpecifier"}
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
    end
  end
end
