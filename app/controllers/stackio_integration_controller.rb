class StackioIntegrationController < ApplicationController
  require 'json'
  require 'rest-client'

  def index

  end
  def create

    api_client = Shotstack::EditApi.new
    video_asset = Shotstack::VideoAsset.new(
    src: "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/footage/skater.hd.mp4",
    trim: 3
  )

    audio_asset = Shotstack::AudioAsset.new(
      src: 'https://shotstack-assets.s3-ap-southeast-2.amazonaws.com/music/unminus/lit.mp3',
      trim: 2,
      volume: 0.5,
      effect: 'fadeInFadeOut'
    )
  video_clip = Shotstack::Clip.new(
    asset: video_asset,
    start: 0,
    length: 10
  )

  track = Shotstack::Track.new(clips: [video_clip])

  timeline = Shotstack::Timeline.new(
    background: "#FF0000",
    tracks: [track])

  output = Shotstack::Output.new(
    format: "mp4",
    resolution: "sd")

  edit = Shotstack::Edit.new(
    timeline: timeline,
    output: output)
  response = api_client.post_render(edit).response
  puts response.id
  end
end

