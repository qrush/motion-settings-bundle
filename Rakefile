#!/usr/bin/env rake
require "bundler/gem_tasks"

desc "Test by generating an app"
task :default do
  dir = "tmp"
  sh "rm -rf #{dir}"
  sh "motion create #{dir}"
  Dir.chdir(dir) do
    File.open("Gemfile", "w") do |f|
      f.write <<-EOF
        source :rubygems
        gem "motion-settings", :path => ".."
      EOF
    end

    sh "bundle"

    File.open("Rakefile", "a") do |f|
      f.write <<-EOF
        require 'bundler'
        Bundler.setup
        require 'motion/settings'
      EOF
    end

    sh "rake"
  end
end
