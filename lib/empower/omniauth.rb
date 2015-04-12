module Empower
  module OmniAuth
    extend ActiveSupport::Concern

    included do
      devise :omniauthable, :omniauth_providers => [:facebook]
    end
  end
end
