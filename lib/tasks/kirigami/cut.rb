require 'kirigami'

namespace :kirigami do

  desc "Cuts images down to web-friendly size"
  task :cut  do
    bash_pattern = "{" + Kirigami.config.image_paths.join(",") + "}"
    Dir[bash_pattern].each do |image_path|
      next if Kirigami.config.exclude_paths.detect do |path|
        path.to_s.in?(File.expand_path(image_path))
      end
      Kirigami::Image.new(image_path, '2400x1600>').tap(&:cut!)
    end
  end

end
