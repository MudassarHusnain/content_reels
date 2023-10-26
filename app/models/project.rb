class Project < ApplicationRecord
  belongs_to :user
  has_many :reels,dependent: :destroy
  Validations :name,presence: true,length: {minimum: 8}
end
