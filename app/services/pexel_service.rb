class PexelService

  Pexel_KEY = Rails.application.credentials[:pexel_key]
  def initialize(*args)
    @image_text = args.first[:image] if args.first[:image]
    @video_text = args.first[:video] if args.first[:video]
  end

  def generate_images
    client = Pexels::Client.new(Pexel_KEY)
    response = client.photos.search(@image_text)
    response.photos
  end

  def generate_videos
    client = Pexels::Client.new(Pexel_KEY)
    videos = client.videos.search(@video_text, per_page: 5)
    videos.each_with_object([]) do |video, response|
      response << video.files[0].link
    end
  end
end