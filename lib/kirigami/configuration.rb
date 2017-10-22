module Kirigami

  module Configuration

    ##
    #
    IMAGE_EXTENSIONS = %w[ png jpg jpeg gif ]

    ##
    #
    EXCLUDE_PATHS = []

    ##
    #
    SAFE_MODE = true

    ##
    #
    JPEG_COMPRESSION_QUALITY = '85%'.freeze

    ##
    #
    JPEG_COLORSPACE = 'RGB'.freeze

    ##
    #
    JPEG_SAMPLING_FACTOR = "4:2:0".freeze

    ##
    #
    JPEG_INTERLACING = "Plane".freeze

    ##
    #
    DEBUG = false


    def self.extended(klass)
      klass.class_eval do
        include ActiveSupport::Configurable

        config.image_extensions ||= IMAGE_EXTENSIONS

        config.image_paths  ||= Array(rails_image_paths)

        config.exclude_paths ||= EXCLUDE_PATHS

        config.safe_mode ||= SAFE_MODE

        config.jpeg_compression_quality ||= JPEG_COMPRESSION_QUALITY

        config.jpeg_colorspace ||= JPEG_COLORSPACE

        config.jpeg_sampling_factor ||= JPEG_SAMPLING_FACTOR

        config.jpeg_interlacing ||= JPEG_INTERLACING

        MiniMagick.configure do |magick|
          magick.debug = Logger::DEBUG if config.debug
        end

      end
    end

    def logger
      @logger ||= Logger.new($stdout, level: config.debug ? Logger::DEBUG : Logger::INFO)
    end


    private


    def rails_assets_path
      File.join("app/assets/images/**/*\.{%{formats}}")
    end

    def rails_image_paths
      rails_assets_path % { formats: config.image_extensions.join(",") }
    end

  end

end
