require 'rake'
require 'rails/generators'

module Empower
  class InstallGenerator < Rails::Generators::Base
    desc "Add OmniAuth config to Devise"

    source_root File.expand_path('../../templates', __FILE__)

    def verify_prereqs
      perform_checks
    end

    def add_devise_config
      insert_into_file(
        'config/initializers/devise.rb',
        "\n  config.omniauth :facebook, 'APP_ID', 'APP_SECRET'",
        :after => 'Devise.setup do |config|'
      )
    end

    def add_model_concern
      insert_into_file(
        'app/models/user.rb',
        "\n\n  include Empower::OmniAuth",
        :after => 'ActiveRecord::Base'
      )
    end

    def add_gems
      insert_into_file(
        'Gemfile',
        "\ngem 'omniauth-facebook'",
        :after => /^source(.*)\n/
      )
    end

    def add_routes
      insert_into_file(
        'config/routes.rb',
        ', :controllers => { :omniauth_callbacks => "empower/omniauth_callbacks" }',
        :after => 'devise_for :users'
      )
    end

    private

      def perform_checks
        # Devise config file
        unless File.exists?("#{Rails.root}/config/initializers/devise.rb")
          msg = "You need to run:\n    bundle exec rails g devise:install"
          msg += "\nbefore running this generator."
          raise_error(msg)
        end
        # User model
        unless File.exists?("#{Rails.root}/app/models/user.rb")
          raise_error('You must have a user model to use Empower')
        end
      end

      def raise_error(msg)
        raise msg
      end

  end
end