require "google/apis/youtube_v3"
require "net/http"

class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    youtube_service = YoutubeService.new
    if @video.save
      file_path = Rails.root.join("public", "video", "test.mp4")

      File.open(file_path, "wb") do |file|
        file.write(@video.video_file.download)
      end
      youtube_service.upload_video_to_youtube(@video, current_user)
      redirect_to videos_path, notice: "Video was successfully uploaded."
    else
      render :new
    end
  end

  def update
    if @video.update(video_params)
      redirect_to root_path, notice: "Video was successfully updated."
    else
      render :edit
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:title, :description, :video_file, :privacy_status)
  end
end
