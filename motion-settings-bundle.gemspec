# -*- encoding: utf-8 -*-
require File.expand_path('../lib/motion-settings-bundle/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nick Quaranto"]
  gem.email         = ["nick@quaran.to"]
  gem.summary = gem.description =
   %{Create a Settings.bundle for your RubyMotion app. This allows your app to have a "global" settings entry in the Settings app.}
  gem.homepage      = "https://github.com/qrush/motion-settings-bundle"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "motion-settings-bundle"
  gem.require_paths = ["lib"]
  gem.version       = Motion::Settings::VERSION

  gem.add_dependency 'plist', '~> 3.1.0'
  gem.add_development_dependency 'rake'
end
