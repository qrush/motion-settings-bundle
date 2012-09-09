unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require "motion/settings/version"

module Motion
  module Settings
    def self.setup

    end
  end
end

desc "Generate a Settings.bundle"
task :settings do
  App.info "Create", "resources/Settings.bundle"
end

%w(build:simulator build:device).each do |build_task|
  Rake::Task[build_task].enhance([:settings])
end
