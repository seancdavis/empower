class EmpowerController < Devise::OmniauthCallbacksController

  private

    def after_sign_in_path_for(resource)
      if resource.email_verified?
        super resource
      else
        empower.finish_signup_path
      end
    end

end
