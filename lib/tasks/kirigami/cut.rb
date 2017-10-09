require 'kirigami'

namespace :kirigami do

  desc "Cuts images down to web-friendly size"
  task :cut  do
    bash_pattern = "{" + Kirigami.config.image_paths.join(",") + "}"
    Dir[bash_pattern].each do |image_path|
      exclude_path = Kirigami.config.exclude_paths.detect do |path|
        File.expand_path(image_path).to_s.starts_with?(path.realpath.to_s)
      end
      if exclude_path
        Kirigami.logger.debug("Skipping image because: #{exclude_path} is excluded")
        next
      else
        Kirigami.logger.debug("Processing image: #{image_path}")
        Kirigami::Image.new(image_path, '2400x1600>').tap(&:cut!)
      end
    end
  end

end
