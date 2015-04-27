module Empower
  module OmniAuth
    extend ActiveSupport::Concern

    included do
      devise :omniauthable, :omniauth_providers => [:facebook]
    end

    module ClassMethods
      def from_omniauth(auth)
        user = User.find_by_email(auth.info.email)
        if user.nil?
          user = User.create!(
            :email => auth.info.email,
            :password => Devise.friendly_token[0,20],
          )
          attrs = {}
          if ActiveRecord::Base.connection.column_exists?(:users, :name, :string)
            attrs[:name] = auth.info.name
          end
          if ActiveRecord::Base.connection.column_exists?(:users, :image, :string)
            attrs[:image] = auth.info.image
          end
          if attrs.keys.size > 0
            user.update_columns(attrs)
          end
        else
          attrs = {}
          if ActiveRecord::Base.connection.column_exists?(:users, :name, :string)
            attrs[:name] = auth.info.name
          end
          if ActiveRecord::Base.connection.column_exists?(:users, :image, :string)
            attrs[:image] = auth.info.image
          end
          if attrs.keys.size > 0
            user.update_columns(attrs)
          end
        end
        user
      end

      def new_with_session(params, session)
        super.tap do |user|
          if data = session["devise.facebook_data"] &&
            session["devise.facebook_data"]["extra"]["raw_info"]
              user.email = data["email"] if user.email.blank?
          end
        end
      end
    end
  end
end
