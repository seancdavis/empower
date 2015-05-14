require 'rake'
require 'rails/generators'

module Empower
  class InstallGenerator < Rails::Generators::Base
    desc "Add OmniAuth config to Devise"

    source_root File.expand_path('../templates', __FILE__)

    def verify_prereqs
      perform_checks
    end

    def add_omniauth_columns_to_users
      cols = ''
      cols += 'name ' unless User.new.respond_to?(:name)
      cols += 'image ' unless User.new.respond_to?(:image)
      unless cols.blank?
        generate "migration add_omniauth_columns_to_users #{cols}"
      end
    end

    def add_identity_model
      generate "model identity user:references provider:string uid:string"
      template "identity_model.rb", "app/models/identity.rb", :force => true
    end

    def add_devise_config
      config  = "\n  config.omniauth :facebook, 'APP_ID', 'APP_SECRET'"
      config += "\n  config.omniauth :google_oauth2, 'APP_ID', 'APP_SECRET'"
      config += "\n  config.omniauth :twitter, 'APP_ID', 'APP_SECRET'"
      insert_into_file(
        'config/initializers/devise.rb',
        config,
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
      insert_into_file(
        'config/routes.rb',
        "  mount Empower::Engine => '/'\n",
        :after => /Rails\.application\.routes\.draw\ do(.*)\n/
      )
    end

    def add_helper
      insert_into_file(
        'app/controllers/application_controller.rb',
        "  helper Empower::OmniauthHelper\n",
        :after => /class\ ApplicationController(.*)\n/
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
