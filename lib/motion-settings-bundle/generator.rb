module Motion
  module Settings
    class Generator
      def initialize(resources_dir)
        @root_path = File.join(resources_dir, "Settings.bundle")
      end

      def configure(configuration)
        @configuration = configuration
      end

      def generate
        directory @root_path

        strings_path = File.join(@root_path, "en.lproj")
        directory strings_path

        strings_file_path = File.join(strings_path, "Root.strings")
        file strings_file_path do |file|
          file.write <<-EOF
/* A single strings file, whose title is specified in your preferences schema. The strings files provide the localized content to display to the user for each of your preferences. */

"Group" = "Group";
"Name" = "Name";
"none given" = "none given";
"Enabled" = "Enabled";
EOF
        end

        plist_file_path = File.join(@root_path, "Root.plist")

        file(plist_file_path, true) do |file|
          file.write({
            "Title"                => "Settings",
            "StringsTable"         => "Root",
            "PreferenceSpecifiers" => @configuration.preferences
          }.to_plist)
        end
      end

      private

      def directory(path)
        unless File.exist?(path)
          FileUtils.mkdir(path)
          App.info "Create", path
        end
      end

      def file(path, force = false)
        if force || !File.exist?(path)
          File.open(path, "w") do |file|
            yield file
          end
          App.info "Create", path
        end
      end
    end
  end
end
