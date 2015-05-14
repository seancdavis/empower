class Empower::UsersController < ApplicationController

  include Empower::RoutesHelper

  before_filter :authenticate_user!
  before_filter :verify_unverified_email

  def edit
  end

  def update
    user = User.find_by_email(params[:user][:email])
    temp_user = current_user
    # if there isn't a user with that email address, we
    # change email address of temp user
    if user.nil?
      current_user.update!(user_params)
      updated_user = current_user
      sign_out temp_user
      sign_in_and_redirect updated_user
    # if there is an existing user with that email address,
    # we find the existing user and delete the temp user
    elsif user != current_user
      sign_out temp_user
      temp_user.identities.first.update(:user => user)
      temp_user.destroy
      sign_in_and_redirect user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:email)
    end

    def verify_unverified_email
      if current_user.email_verified?
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    def after_sign_in_path_for(resource)
      if resource.email_verified?
        stored_location_for(resource) || main_app.root_path
      else
        empower.finish_signup_path
      end
    end

end
