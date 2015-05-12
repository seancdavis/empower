class Empower::OmniauthCallbacksController < EmpowerController

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication
          set_flash_message(
            :notice,
            :success,
            :kind => "#{provider}".capitalize
          ) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  def failure
    redirect_to(
      (session[:redirect] || main_app.root_path),
      :alert => "Could not authenticate your request."
    )
  end

  [:facebook, :google_oauth2].each do |provider|
    provides_callback_for provider
  end

end
