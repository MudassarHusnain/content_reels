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

      file_path = Rails.root.join("storage", "video", "test.mp4")
      File.open(file_path, "wb") do |file|
        file.write(@video.video_file.download)
      end
      youtube_service.upload_video_to_youtube(@video, current_user)
      redirect_to videos_path, notice: "Video was successfully uploaded."
    else
      render :new
    end
  end

  def render_video
    shots = ShotstackService.new
    #text = "jo marzi likh le"
    string = "WHO.IS.IMRAN.KHAN"

    audio_src = "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/disco.mp3"
    shots.text_to_video(string, audio_src)
    # shots.video_filter

    #api_client = Shotstack::EditApi.new
    # @id = shots.image_to_video

    # @url = api_client.get_render(@id.id, { data: false, merged: true }).response

    # puts "this is from controller #{@url.url}"
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
