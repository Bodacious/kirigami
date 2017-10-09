# Kirigami

Cut the images in your assets dir to a web-friendly size.

Kirigami performs optimisations on your images to ensure they are web-friendly.

By default, Kirigami uses the optimisation suggestions recommended by
[Google's Page Speed Insights](https://developers.google.com/speed/docs/insights/OptimizeImages)

In ImageMagick terms, these are:

    convert original.jpg -sampling-factor 4:2:0 -strip -quality 85 -interlace JPEG -colorspace RGB new.jpg

Image dimensions, extensions, and filenames are not changed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kirigami'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kirigami

## Usage

**WARNING:** This will change the size and quality of images in your Rails application.
Make sure you have read the documentation and have backed up your images before you proceed

`$ rails kirigami:cut`

This rake task will go through each of the images specified in your configuration and
crop their size (if necessary), remove any metadata, and compress them (JPG only).

To peek under the hood, check out [lib/kirigami/image.rb](lib/kirigami/image.rb#L17-L30)

## Configuration

To configure options, add an initializer in `config/initializers/kirigami.rb`

``` ruby
Kirigami.configure do |config|

  # Only convert images with these extensions (default: %w[ png jpg jpeg gif ])
  self.config.image_extensions  ||= %w[ png jpg jpeg gif ]

  # Create a backup copy of each image before conversion (default: true)
  self.config.safe_mode         ||= true

  # JPEG compression quality (default: "85%")
  self.config.jpeg_compression_quality ||= '85%'

  # An array of dirpaths where your images are located (defaults: "./app/assets/images")
  self.config.image_paths ||= "[yourapp]/app/assets/images"

  # Ignore images within these dirpaths (default: [])
  self.config.exclude_paths     ||= []

  # Set minimagick to debug mode (default: false)
  self.config.debug = false

end
```

## TODO

- [] Add support for specifying max sizes for individual images
- [] Add proper tests

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/katanacode/kirigami.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
