require "net/http"

class ShotstackService
  def text_to_video(text, audio_src,video,images)
    #iniinitialize
    api_client = Shotstack::EditApi.new
    videos =video
    clips = []
    start = 0
    length = 6
    #generate video
    if videos.present?
    videos.each_with_index do |video, index|
      video_asset = Shotstack::VideoAsset.new(
        src: video,
        )

      clip = Shotstack::Clip.new(
        asset: video_asset,
        length: length,
        start: start,
        effect: "zoomIn",
        )

      start += length
      clips.push(clip)
    end
    end
    #generate text
    script = text.split(".")

    soundtrack = Shotstack::Soundtrack.new(
      effect: "fadeInFadeOut",
      src: audio_src,

    )
    title_clip = []
    title_asset = []
    track = []
    start = 0
    length = 6
    size=0
    script.each_with_index do |text, index|
      title_asset[index] = Shotstack::TitleAsset.new(
        text: text,
        color: "#000000",

      )
      title_clip[index] = Shotstack::Clip.new(
        asset: title_asset[index],
        length: length,
        start: start,
        effect: "zoomIn",

      )
      #add text into track
      track[index] = Shotstack::Track.new(clips: [title_clip[index]])
      size=size+1
      start += length
    end
    #add video into track
    if videos.present?
    track[size] = Shotstack::Track.new(clips: clips)
    size=size+1
    end
    if images.present?
    clips = []
    start = 0
    length = 6
    #generate image
    images.each_with_index do |image, index|
      image_asset = Shotstack::ImageAsset.new(
        src: image,
        )

      clip = Shotstack::Clip.new(
        asset: image_asset,
        length: length,
        start: start,
        effect: "zoomIn",
        )

      start += length
      clips.push(clip)
    end

    track[size] = Shotstack::Track.new(clips: clips)
    end
    timeline = Shotstack::Timeline.new(
      background: "#FFFFFF",
      soundtrack: soundtrack,
      tracks: track,
    )
    output = Shotstack::Output.new(
      format: "mp4",
      resolution: "hd",

    )
    edit = Shotstack::Edit.new(
      timeline: timeline,
      output: output,
      callback: "https://www.youtube.com/watch?v=qGPtVVYNLCs",
    )
    begin
      response = api_client.post_render(edit).response
      id = response.id
      puts "id is #{id}"
    rescue => error
      abort("Request failed: #{error.message}")
    end
    puts ">> Now check the progress of your render by running:"
    puts ">> ruby examples/status.rb #{response.id}"
    return id
  end

  def video_filter
    filters = [
      "original",
      "boost",
      "contrast",
      "muted",
      "darken",
      "lighten",
      "greyscale",
      "negative",
    ]

    api_client = Shotstack::EditApi.new
    soundtrack = Shotstack::Soundtrack.new(
      effect: "fadeInFadeOut",
      src: "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/freeflow.mp3",
    )

    video_clips = []
    title_clips = []
    start = 0
    length = 3
    trim = 0
    cut = length

    filters.each_with_index do |filter, index|
      # video clips
      video_asset = Shotstack::VideoAsset.new(
        src: "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/footage/skater.hd.mp4",
        trim: trim,
      )

      video_clip = Shotstack::Clip.new(
        asset: video_asset,
        start: start,
        length: length,
      )

      if filter != "original"
        video_transition = Shotstack::Transition.new(
          _in: "wipeRight",
        )

        video_clip.filter = filter
        video_clip.transition = video_transition
        video_clip.length = length + 1
      end

      video_clips.push(video_clip)

      # title clips
      title_transition = Shotstack::Transition.new(
        _in: "fade",
        out: "fade",
      )

      title_asset = Shotstack::TitleAsset.new(
        text: filter,
        style: "minimal",
        size: "x-small",
      )

      title_clip = Shotstack::Clip.new(
        asset: title_asset,
        length: length - (start == 0 ? 1 : 0),
        start: start,
        transition: title_transition,
      )

      title_clips.push(title_clip)
      trim = cut - 1
      cut = trim + length + 1
      start = trim
    end

    track1 = Shotstack::Track.new(clips: title_clips)
    track2 = Shotstack::Track.new(clips: video_clips)

    timeline = Shotstack::Timeline.new(
      background: "#000000",
      soundtrack: soundtrack,
      tracks: [track1, track2],
    )

    output = Shotstack::Output.new(
      format: "mp4",
      resolution: "sd",
    )

    edit = Shotstack::Edit.new(
      timeline: timeline,
      output: output,
    )

    begin
      response = api_client.post_render(edit).response
    rescue => error
      abort("Request failed: #{error.message}")
    end

    puts response.message
    puts ">> Now check the progress of your render by running:"
    puts ">> ruby examples/status.rb #{response.id}"
  end
  def generate_video(video)
    videos =video
    api_client = Shotstack::EditApi.new
    soundtrack = Shotstack::Soundtrack.new(
      effect: "fadeInFadeOut",
      src: "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/gangsta.mp3",
    )
    clips = []
    start = 0
    length = 1.5

    videos.each_with_index do |video, index|
      video_asset = Shotstack::VideoAsset.new(
        src: video,
      )

      clip = Shotstack::Clip.new(
        asset: video_asset,
        length: length,
        start: start,
        effect: "zoomIn",
      )

      start += length
      clips.push(clip)
    end

    track1 = Shotstack::Track.new(clips: clips)
    timeline = Shotstack::Timeline.new(
      background: "#000000",
      soundtrack: soundtrack,
      tracks: [track1],
    )

    output = Shotstack::Output.new(
      format: "mp4",
      resolution: "sd",
      fps: 30,
    )

    edit = Shotstack::Edit.new(
      timeline: timeline,
      output: output,
    )

    begin
      response = api_client.post_render(edit).response

      id = response.id
      response = api_client.get_render(id, { data: false, merged: true }).response
    rescue => error
      abort("Request failed: #{error.message}")
    end

    puts response
    puts ">> Now check the progress of your render by running:"
    puts ">> ruby examples/status.rb #{response.url}"
    return response
  end
  def image_to_video
    images = [
      "https://i.ibb.co/wzhD5J0/MG-2038.jpg",
      "https://i.ibb.co/HDqGT7d/MG-2042.jpg",
      "https://i.ibb.co/hWnt80M/MG-2043.jpg",
      "https://i.ibb.co/F8WtZSB/MG-2044.jpg",

    ]

    api_client = Shotstack::EditApi.new

    soundtrack = Shotstack::Soundtrack.new(
      effect: "fadeInFadeOut",
      src: "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/gangsta.mp3",
    )

    clips = []
    start = 0
    length = 1.5

    images.each_with_index do |image, index|
      image_asset = Shotstack::ImageAsset.new(
        src: image,
      )

      clip = Shotstack::Clip.new(
        asset: image_asset,
        length: length,
        start: start,
        effect: "zoomIn",
      )

      start += length
      clips.push(clip)
    end

    track1 = Shotstack::Track.new(clips: clips)
    timeline = Shotstack::Timeline.new(
      background: "#000000",
      soundtrack: soundtrack,
      tracks: [track1],
    )

    output = Shotstack::Output.new(
      format: "mp4",
      resolution: "sd",
      fps: 30,
    )

    edit = Shotstack::Edit.new(
      timeline: timeline,
      output: output,
    )

    begin
      response = api_client.post_render(edit).response

      id = response.id
      response = api_client.get_render(id, { data: false, merged: true }).response
    rescue => error
      abort("Request failed: #{error.message}")
    end

    puts response
    puts ">> Now check the progress of your render by running:"
    puts ">> ruby examples/status.rb #{response.url}"
    return response
  end

  def generate_video(video)
    videos = video
    api_client = Shotstack::EditApi.new

    soundtrack = Shotstack::Soundtrack.new(
      effect: "fadeInFadeOut",
      src: "https://s3-ap-southeast-2.amazonaws.com/shotstack-assets/music/gangsta.mp3",
      )
    clips = []
    start = 0
    length = 1.5

    videos.each_with_index do |video, index|
      video_asset = Shotstack::VideoAsset.new(
        src: video,
        )

      clip = Shotstack::Clip.new(
        asset: video_asset,
        length: length,
        start: start,
        effect: "zoomIn",
        )

      start += length
      clips.push(clip)
    end

    track1 = Shotstack::Track.new(clips: clips)
    timeline = Shotstack::Timeline.new(
      background: "#000000",
      soundtrack: soundtrack,
      tracks: [track1],
      )

    output = Shotstack::Output.new(
      format: "mp4",
      resolution: "sd",
      fps: 30,
      )

    edit = Shotstack::Edit.new(
      timeline: timeline,
      output: output,
      )

    begin
      response = api_client.post_render(edit).response

      id = response.id
      response = api_client.get_render(id, { data: false, merged: true }).response
    rescue => error
      abort("Request failed: #{error.message}")
    end

    puts response
    puts ">> Now check the progress of your render by running:"
    puts ">> ruby examples/status.rb #{response.url}"
    return response
  end
end
