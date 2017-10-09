require 'mini_magick'
require 'active_support/configurable'

require "kirigami/version"
if defined?(Rails)
  require 'kirigami/railtie'
else
  warn "Kirigami is currently configured for Rails projects."
end
require 'kirigami/image'

module Kirigami
  include ActiveSupport::Configurable

  self.config.image_extensions  ||= %w[ png jpg jpeg gif ]

  self.config.exclude_paths     ||= []

  self.config.safe_mode         ||= true

  self.config.jpeg_compression_quality ||= '85%'

  self.config.jpeg_colorspace ||= 'RGB'

  self.config.jpeg_sampling_factor ||= "4:2:0"

  self.config.jpeg_interlacing ||= "JPEG"


  if defined?(Rails)
    rails_assets_path = File.join "./app/assets/images/**/*\.{%{formats}}"
    rails_image_paths = rails_assets_path % { formats: config.image_extensions.join(",") }
    self.config.image_paths ||= Array(rails_image_paths)
  end

  self.config.debug = false

  MiniMagick.configure do |config|
    config.debug = Logger::DEBUG if self.config.debug
  end

end
