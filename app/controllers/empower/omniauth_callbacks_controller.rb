require_dependency "empower_controller"

class Empower::OmniauthCallbacksController < EmpowerController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user #this will throw if @user is not activated
      redirect_to redirect_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to redirect_path
    end
  end

  def failure
    redirect_to(
      (session[:redirect] || main_app.root_path),
      :alert => "Could not authenticate your request."
    )
  end

  private

    def redirect_path
      if defined? omniauth_redirect_path
        omniauth_redirect_path(@user)
      else
        main_app.root_path
      end
    end

end
