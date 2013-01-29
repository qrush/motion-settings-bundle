module Motion
  module SettingsBundle
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
        file strings_file_path do |io|
          io.write <<-EOF
/* A single strings file, whose title is specified in your preferences schema. The strings files provide the localized content to display to the user for each of your preferences. */

"Group" = "Group";
"Name" = "Name";
"none given" = "none given";
"Enabled" = "Enabled";
EOF
        end

        plist_file_path = File.join(@root_path, "Root.plist")

        file(plist_file_path, true) do |io|
          io.write({
            "Title"                => "Settings",
            "StringsTable"         => "Root",
            "PreferenceSpecifiers" => @configuration.preferences
          }.to_plist)
        end

        generate_children(@configuration.children)
      end

      private

      def generate_children(children)
        children.each do |title, child|
          file(File.join(@root_path, "#{title}.plist"), true) do |io|
            io.write({
              "Title"                => title,
              "StringsTable"         => title,
              "PreferenceSpecifiers" => child.preferences
            }.to_plist)
          end

          generate_children(child.children)
        end
      end

      def directory(path)
        unless File.exist?(path)
          FileUtils.mkdir(path)
          App.info "Create", path
        end
      end

      def file(path, force = false)
        if force || !File.exist?(path)
          File.open(path, "w") do |io|
            yield io
          end
          App.info "Create", path
        end
      end
    end
  end
end
