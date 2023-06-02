class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end
end
