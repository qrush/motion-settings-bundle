# motion-settings

Create a Settings.bundle for your RubyMotion app. This allows your app to have a "global" settings entry in the Settings app.

Note: This project really solely exists to avoid creating/editing the Settings.bundle in XCode. The specs for it so far have been based off mordaroso/rubymotion-settings. Please feel free to contribute more ways to generate settings!

## Installation

Add this line to your application's Gemfile:

    gem 'motion-settings'

And then execute:

    bundle

Or install it yourself as:

    gem install motion-settings

## Usage

Add a chunk of code into your project's `Rakefile` like so:

``` ruby
require 'motion/settings'

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
```

Now just run `rake` as normal!

This should now add a `Settings.bundle` folder into your `resources` directory. Make sure to commit it! If you ever change the data in the `Settings.setup` block, it will be re-built on the next `rake` run.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT. See `LICENSE`.
