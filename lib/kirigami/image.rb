module Kirigami
  class Image

    attr_reader :max_size

    attr_reader :path

    # Create a new Image
    #
    # max_size - An ImageSize to specify the size and name of image.
    def initialize(path, max_size)
      @path          = path
      @max_size      = max_size
    end

    # Writes the resized image to disk
    def cut!
      create_backup_copy
      MiniMagick::Tool::Mogrify.new do |mogrify|
        mogrify.resize(max_size)
        mogrify.strip
        if jpeg?
          mogrify.colorspace 'RGB'
          mogrify.sampling_factor "4:2:0"
          mogrify.interlace "JPEG"
          mogrify.quality(Kirigami.config.jpeg_compression_quality)
        end
        mogrify << target_filepath
      end
    end

    def target_filepath
      File.join(File.dirname(path), filename)
    end

    def filename
      File.basename(path)
    end

    def backup_filename
      File.basename(path) + ".BAK"
    end

    def backup_filepath
      File.join(File.dirname(path), backup_filename)
    end

    def jpeg?
      filename.ends_with?(".jpg")
    end


    private


    def create_backup_copy
      FileUtils.cp(target_filepath, backup_filepath)
    end

    def scaled_image
      template_image.resize("#{target_width}x#{target_height}")
    end

    def template_image
      MiniMagick::Image.open(path)
    end

    def target_width
      max_size.to_s.split('x').first
    end

    def target_height
      max_size.to_s.split('x').last
    end

  end

end
