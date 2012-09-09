unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require "fileutils"
require "motion/settings/generator"
require "motion/settings/version"

module Motion
  module Settings
    def self.setup

    end

    def self.generate
      generator = Generator.new(App.config.resources_dir)
      generator.generate
    end
  end
end

desc "Generate a Settings.bundle"
task :settings do
  Motion::Settings.generate
end

%w(build:simulator build:device).each do |build_task|
  Rake::Task[build_task].enhance([:settings])
end
