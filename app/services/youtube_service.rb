require "google/apis/youtube_v3"

class YoutubeService
  def upload_video_to_youtube(videos, user)
    client = Google::Apis::YoutubeV3::YouTubeService.new
    client.authorization = user.youtube_token

    video = Google::Apis::YoutubeV3::Video.new(
      snippet: {
        title: videos.title,
        description: videos.description,
        tags: ["tag1", "tag2"],
      },
      status: {
        privacy_status: videos.privacy_status,
      },
    )

    video_file_path = "storage/video/test.mp4"
    begin
      video_object = client.insert_video("snippet,status", video, upload_source: video_file_path, content_type: "video/*")
      puts "Video ID: #{video_object.id}"
      puts "Video Title: #{video_object.snippet.title}"
    rescue Google::Apis::ClientError => e
      puts "Error uploading video: #{e.message}"
    end
  end
end
