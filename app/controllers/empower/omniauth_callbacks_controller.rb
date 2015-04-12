require_dependency "empower/application_controller"

module Empower
  class OmniauthCallbacksController < ApplicationController

    def facebook
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        if request.env['omniauth.origin'].split('/').last == 'login'
          sign_in @user #this will throw if @user is not activated
          redirect_to main_app.root_path
        else
          sign_in_and_redirect @user
        end
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to main_app.root_path
      end
    end

    def failure
      redirect_to(
        (session[:redirect] || main_app.root_path),
        :alert => "Could not authenticate your request."
      )
    end
  end
end
