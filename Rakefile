#!/usr/bin/env rake
require "bundler/gem_tasks"

desc "Test by generating an app"
task :default do
  dir = "MotionSettingsTest"
  `rm -rf #{dir}`
  `motion create #{dir}`
  Dir.chdir(dir) do
    File.open("Gemfile", "w") do |f|
      f.write <<-EOF
        source :rubygems
        gem "motion-settings-bundle", :path => ".."
      EOF
    end

    `bundle --local`

    File.open("Rakefile", "a") do |f|
      f.write <<-EOF

require 'bundler'
Bundler.setup

require 'motion-settings-bundle'

Motion::SettingsBundle.setup do |app|
  # A text field. Allows configuration of a string.
  app.text "Name", key: "username", default: "Paul Atreides"
  app.text "E-mail", key: "email", keyboard: "EmailAddress", autocapitalization: "None"
  app.text "Password", key: "password", secure: true

  # A read-only text field. Use for showing a small chunk of text, maybe a version number
  app.title "Year of Birth", key: "yearOfBirth", default: "10,175 AG"

  # An on/off switch. Turn something on or off. Default is `false` (off).
  app.toggle "Kwisatz Haderach?", key: "superpowersEnabled", default: true

  # A slider, configure volume or something linear
  app.slider "Spice Level", key: "spiceLevel", default: 50, min: 1, max: 100

  # Child pane to display licenses in
  app.child "Acknowledgements" do |ack|
    ack.child "AwesomeOSSLibrary" do |lic|
      lic.group "Copyright 2013 AwesomeOSSContributor"
      lic.group "More license text that is terribly formatted but fulfills legal requirements"
    end
  end
end
      EOF
    end

    puts "*" * 80
    puts "Booting up the simulator! Jump to the Settings app once booted and open '#{dir}'."
    puts "*" * 80
    sh "rake"
  end
end
