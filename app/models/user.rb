class User < ApplicationRecord
  # Include default devise modules. Others available are:
  has_many :courses
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def self.from_omniauth(auth, current_user)
    current_user.youtube_token = auth.credentials.token
    current_user.save
  end

  def self.from_fb_omniauth(auth, current_user)
    current_user.facebook_token = auth.credentials.token
    current_user.save
  end
end
