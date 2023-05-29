class IntegrationController < ApplicationController
  require "httparty"

  def index
  end

  def create
    login_url = FacebookService.login
    redirect_to login_url, allow_other_host: true
  end

  def facebook_callback
    fetch_data = FacebookService.new({ code: params[:code], token: session[:token] })
    session[:token] = fetch_data.get_token
    @data = fetch_data.facebook_call
  end

  def post_content
    post_data = FacebookService.new({ id: params[:id], token: session[:token] })
    post_data.upload_content
  end
end
