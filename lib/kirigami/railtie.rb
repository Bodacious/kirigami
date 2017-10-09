module Kirigami
  class Railtie < Rails::Railtie
    rake_tasks do

      require_relative '../tasks/kirigami/cut.rb'
    end
  end
end
