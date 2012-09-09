module Motion
  module Settings
    class Generator
      def initialize(resources_dir)
        @root_path = File.join(resources_dir, "Settings.bundle")
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

        file plist_file_path do |file|
          file.write <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Title</key>
	<string>Settings</string>
	<key>StringsTable</key>
	<string>Root</string>
	<key>PreferenceSpecifiers</key>
	<array>
		<dict>
			<key>Type</key>
			<string>PSTextFieldSpecifier</string>
			<key>Title</key>
			<string>Text Entry</string>
			<key>Key</key>
			<string>textEntry_key</string>
			<key>DefaultValue</key>
			<string>Simple Text</string>
			<key>IsSecure</key>
			<false/>
			<key>KeyboardType</key>
			<string>Alphabet</string>
			<key>AutoCapitalizationType</key>
			<string>Sentences</string>
			<key>AutocorrectionType</key>
			<string>Default</string>
		</dict>
		<dict>
			<key>Title</key>
			<string>Read Only</string>
			<key>Key</key>
			<string>readOnly_key</string>
			<key>DefaultValue</key>
			<string>Read Only Value</string>
			<key>Type</key>
			<string>PSTitleValueSpecifier</string>
		</dict>
		<dict>
			<key>Type</key>
			<string>PSToggleSwitchSpecifier</string>
			<key>Title</key>
			<string>Toogle</string>
			<key>Key</key>
			<string>toogle_key</string>
			<key>DefaultValue</key>
			<string>YES</string>
			<key>TrueValue</key>
			<string>YES</string>
			<key>FalseValue</key>
			<string>YES</string>
		</dict>
		<dict>
			<key>Type</key>
			<string>PSSliderSpecifier</string>
			<key>Key</key>
			<string>slider_key</string>
			<key>DefaultValue</key>
			<integer>1</integer>
			<key>MinimumValue</key>
			<integer>1</integer>
			<key>MaximumValue</key>
			<integer>100</integer>
		</dict>
		<dict>
			<key>Type</key>
			<string>PSGroupSpecifier</string>
			<key>Title</key>
			<string>Group2</string>
		</dict>
		<dict>
			<key>Type</key>
			<string>PSMultiValueSpecifier</string>
			<key>Title</key>
			<string>Colors</string>
			<key>Key</key>
			<string>colors_key</string>
			<key>DefaultValue</key>
			<string>1</string>
			<key>Values</key>
			<array>
				<string>1</string>
				<string>2</string>
				<string>3</string>
			</array>
			<key>Titles</key>
			<array>
				<string>Blue</string>
				<string>Red</string>
				<string>Green</string>
			</array>
		</dict>
	</array>
</dict>
</plist>
EOF
        end
      end

      private

      def directory(path)
        unless File.exist?(path)
          FileUtils.mkdir(path)
          App.info "Create", path
        end
      end

      def file(path)
        unless File.exist?(path)
          File.open(path, "w") do |file|
            yield file
          end
          App.info "Create", path
        end
      end
    end
  end
end
