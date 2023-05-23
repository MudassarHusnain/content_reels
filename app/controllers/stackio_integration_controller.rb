class StackioIntegrationController < ApplicationController
  require 'json'
  require 'rest-client'

  def create
  api_client = Shotstack::EditApi.new
  video_asset = Shotstack::VideoAsset.new(
    src: "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/footage/skater.hd.mp4",
    trim: 3
  )

  video_clip = Shotstack::Clip.new(
    asset: video_asset,
    start: 0,
    length: 8
  )

  track = Shotstack::Track.new(clips: [video_clip])

  timeline = Shotstack::Timeline.new(
    background: "#000000",
    tracks: [track])

  output = Shotstack::Output.new(
    format: "mp4",
    resolution: "sd")

  edit = Shotstack::Edit.new(
    timeline: timeline,
    output: output)
  response = api_client.post_render(edit).response
  puts response
  id = response.id

  merge_field_url = Shotstack::MergeField.new(
    find: "URL",
    replace: "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/footage/skater.hd.mp4"
  )

  merge_field_trim = Shotstack::MergeField.new(
    find: "TRIM",
    replace: 3
  )

  merge_field_length = Shotstack::MergeField.new(
    find: "LENGTH",
    replace: 6
  )

  template = Shotstack::TemplateRender.new(
    id: id,
    merge: [
      merge_field_url,
      merge_field_trim,
      merge_field_length
    ]
  )

  response = api_client.post_template_render(template).response

  puts response
  end
end

