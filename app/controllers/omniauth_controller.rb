class OmniauthController < ApplicationController
  def facebook
    @user = user.create_from_provider_data(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      flash[:error] = "There was problem signing in through facebook"
      redirect_to new_user_registration_path
    end
  end
end
