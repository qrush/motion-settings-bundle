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
        gem "motion-settings", :path => ".."
      EOF
    end

    `bundle --local`

    File.open("Rakefile", "a") do |f|
      f.write <<-EOF

require 'bundler'
Bundler.setup

require 'motion-settings'

Motion::Settings.setup do |app|
  # A text field. Allows configuration of a string.
  app.text "Name", key: "username", default: "Paul Atreides"

  # A read-only text field. Use for showing a small chunk of text, maybe a version number
  app.title "Year of Birth", key: "yearOfBirth", default: "10,175 AG"

  # An on/off switch. Turn something on or off. Default is `false` (off).
  app.toggle "Kwisatz Haderach?", key: "superpowersEnabled", default: true

  # A slider, configure volume or something linear
  app.slider "Spice Level", key: "spiceLevel", default: 50, min: 1, max: 100

  # Jump to a screen and choose from a list of options
  app.group "Occupation", key: "occupation" do |group|
    group.option "Padishah Emperor"
    group.option "Mentat", default: true
    group.option "Duke of House Atreides"
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
