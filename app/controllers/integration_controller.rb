class IntegrationController < ApplicationController
  require 'httparty'
  include Integration
  def index
    if check_session
      connected
    end
  end

  def facebook_callback
    fb_token = current_user.facebook_token
    fetch_data = FacebookService.new({token: fb_token})
    @data = fetch_data.facebook_call(fb_token)
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Account connected successfully." }
    end
  end

  def post_content
    post_data = FacebookService.new({id: params[:id], token: current_user.facebook_token})
    selected_value = params[:id].split(',')
    type = selected_value[1]
    type == 'GROUPS' ? post_data.delay.publish_video_on_group(params[:reel_id]) : post_data.delay.publish_video_on_page(params[:reel_id])
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Video Uploaded successfully." }
    end
  end

  def destroy_session
    current_user.facebook_token = nil
    current_user.save
    disconnected
    respond_to do |format|
      format.html { redirect_to integration_path, notice: "Account disconnected." }
    end
  end
end