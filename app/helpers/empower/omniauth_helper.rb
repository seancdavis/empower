module Empower
  module OmniauthHelper

    def facebook_login_button(text = 'Sign in with Facebook')
      link_to(
        text,
        main_app.user_omniauth_authorize_path(:facebook),
        :class => 'button facebook'
      ) unless user_signed_in?
    end

  end
end
