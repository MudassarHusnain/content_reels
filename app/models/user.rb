class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :projects

  def self.from_omniauth(auth, current_user)
    current_user.youtube_token = auth.credentials.token
    current_user.microphone_audio
  end

  def self.from_fb_omniauth(auth, current_user)
    current_user.facebook_token = auth.credentials.token
    current_user.microphone_audio
  end

  def facebook_connected?
    facebook_token.present?
  end
end
