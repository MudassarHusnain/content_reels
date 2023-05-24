class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    @user = from_omniauth(request.env["omniauth.auth"])
    redirect_to new_video_path
  end

  private
  def from_omniauth(auth)
    current_user.youtube_token = auth.credentials.token
    current_user.save
  end

end
