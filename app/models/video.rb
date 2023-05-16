class Video < ApplicationRecord
  has_one_attached :video_file

  validate :validate_video_format

  def validate_video_format
    if video_file.attached? && !video_file.content_type.in?(%w[video/mp4 video/quicktime])
      errors.add(:video_file, "must be a valid video format")
      video_file.purge
    end
  end
end
