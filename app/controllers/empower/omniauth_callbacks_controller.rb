require_dependency "empower_controller"

class Empower::OmniauthCallbacksController < EmpowerController

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user #this will throw if @user is not activated
      redirect_to after_sign_in_path_for(@user)
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to after_sign_in_path_for(@user)
    end
  end

  def failure
    redirect_to(
      (session[:redirect] || main_app.root_path),
      :alert => "Could not authenticate your request."
    )
  end

end
