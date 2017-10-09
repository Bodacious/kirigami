require 'mini_magick'
require 'active_support/configurable'

require "kirigami/version"
if defined?(Rails)
  require 'kirigami/railtie'
else
  warn "Kirigami is currently configured for Rails projects."
end
require 'kirigami/image'
require 'kirigami/configuration'
module Kirigami
  extend Kirigami::Configuration
end
