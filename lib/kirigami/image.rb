module Kirigami
  # An Image file to be compressed and cut via Kirigami
  class Image

    ##
    # An ImageMagick Image Geometry for the target file size
    # http://www.imagemagick.org/script/command-line-processing.php#geometry
    #
    # Returns String
    attr_reader :max_size


    ##
    # The filepath of the image to be cut
    #
    # Returns Pathname
    attr_reader :path

    # Create a new Image
    #
    # max_size - An ImageSize to specify the size and name of image.
    def initialize(path, max_size)
      @path          = path
      @max_size      = max_size
    end

    # Cuts the File down to size! Creates a backup copy first, if required.
    def cut!
      create_backup_copy
      MiniMagick::Tool::Mogrify.new do |mogrify|
        mogrify.resize(max_size)
        mogrify.strip
        if jpeg?
          mogrify.colorspace(Kirigami.config.jpeg_colorspace)
          mogrify.sampling_factor(Kirigami.config.jpeg_sampling_factor)
          mogrify.interlace(Kirigami.config.jpeg_interlacing)
          mogrify.quality(Kirigami.config.jpeg_compression_quality)
        end
        mogrify << target_filepath
      end
    end


    private


    # Create a backup copy of the File first
    def create_backup_copy
      FileUtils.cp(target_filepath, backup_filepath) if Kirigami.config.safe_mode
    end

    # The absolute filepath for the target File
    #
    # Returns Pathname
    def target_filepath
      File.join(File.dirname(path), filename)
    end

    # The filename for the target File
    #
    # Returns String
    def filename
      File.basename(path)
    end

    # The filename for the backup File. Uses {filename} + ".BAK"
    #
    # Returns String
    def backup_filename
      File.basename(path) + ".BAK"
    end

    # The absolute filepath for the backup File
    #
    # Returns Pathname
    def backup_filepath
      File.join(File.dirname(path), backup_filename)
    end

    # Is the target File a JPEG?
    #
    # Returns Boolean
    def jpeg?
      filename.ends_with?(".jpg")
    end

  end

end
