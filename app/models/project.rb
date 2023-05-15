class Project < ApplicationRecord
  belongs_to :user
  has_many :reels,dependent: :destroy
end
