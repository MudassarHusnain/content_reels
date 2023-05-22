class IntegrationController < ApplicationController
  require 'httparty'
 
  def index
  end
 
  def create
    login_url = FacebookService.login
    redirect_to login_url, allow_other_host: true

  end

  def facebook_callback
    fetch_data = FacebookService.new({code: params[:code], token: session[:token]})
    token = fetch_data.get_token
    session[:token] = token
    @data = fetch_data.facebook_call(token)
  end

  def post_content
    post_data = FacebookService.new({id: params[:id], token: session[:token]})
    selected_value = params[:id].split(',')
    type = selected_value[1]
    if type == 'GROUPS'
    post_data.delay.publish_video_on_group
    else if type == 'PAGES'
      post_data.delay.publish_video_on_page
      end
    end
    redirect_to integration_path, notice: 'Video Uploaded successfully.'
  end
end