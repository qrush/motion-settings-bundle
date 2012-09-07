unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require "motion-settings/version"

desc "Generate a Settings.bundle"
task :settings do
  puts "test"
end
