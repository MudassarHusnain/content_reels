class Reel < ApplicationRecord
  belongs_to :project
  has_many :templates
end
