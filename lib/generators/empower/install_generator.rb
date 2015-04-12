require 'rake'
require 'rails/generators'

module Empower
  class InstallGenerator < Rails::Generators::Base
    desc "Add Empower config file to your initializers."

    source_root File.expand_path('../../templates', __FILE__)

    # Copy our Empower config file into the project's
    # config/initializers directory.
    #
    def add_config_file
      config_file = "config/initializers/empower.rb"
      copy_file config_file, config_file
    end

  end
end
