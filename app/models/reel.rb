class Reel < ApplicationRecord
  # include ActiveModel::Validations
  belongs_to :project
  has_many :templates
end
