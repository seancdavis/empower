module Empower
  module OmniauthHelper

    def facebook_login_button(text = 'Sign in with Facebook')
      link_to(
        text,
        main_app.user_omniauth_authorize_path(:facebook),
        :class => 'button facebook'
      ) unless user_signed_in?
    end

    def google_login_button(text = 'Sign in with Google')
      link_to(
        text,
        main_app.user_omniauth_authorize_path(:google_oauth2),
        :class => 'button google'
      ) unless user_signed_in?
    end

    def twitter_login_button(text = 'Sign in with Twitter')
      link_to(
        text,
        main_app.user_omniauth_authorize_path(:twitter),
        :class => 'button twitter'
      ) unless user_signed_in?
    end

  end
end
