unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require "fileutils"

require "plist"

require "motion-settings/configuration"
require "motion-settings/generator"
require "motion-settings/version"

module Motion
  module Settings
    class << self
      attr_accessor :generator

      def setup(&block)
        generator.configure(Configuration.new(&block))
      end
    end

    self.generator = Generator.new(App.config.resources_dir)
  end
end

desc "Generate a Settings.bundle"
task :settings do
  Motion::Settings.generator.generate
end

%w(build:simulator build:device).each do |build_task|
  Rake::Task[build_task].enhance([:settings])
end
