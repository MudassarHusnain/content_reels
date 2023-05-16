class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :projects

  def self.from_omniauth(auth, current_user)
    current_user.youtube_token = auth.credentials.token
    current_user.save
  end
  def self.create_from_provider_data(provider_data)
    Rails.logger.debug "Show this message!"
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
