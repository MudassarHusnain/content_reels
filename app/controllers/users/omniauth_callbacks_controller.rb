class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Integration
  # skip_before_action :verify_authenticity_token
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"], current_user)
    redirect_to new_video_path
  end

  def facebook
    if check_session
      redirect_to callback_integration_path
    else
      @user = User.from_fb_omniauth(request.env["omniauth.auth"], current_user)
      redirect_to callback_integration_path
    end

  end

end
