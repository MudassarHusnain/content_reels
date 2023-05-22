class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"], current_user)
    redirect_to new_video_path
  end
  def facebook
    # Retrieve the user's Facebook access token
    @user = User.from_fb_omniauth(request.env["omniauth.auth"], current_user)
    byebug
    # Update the user's access token in the database
    current_user.update(facebook_access_token: session[:token])

    # Redirect to the desired page
    redirect_to callback_integration_path
  end
end
