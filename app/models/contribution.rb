class Contribution < ApplicationRecord

  belongs_to :customer
  has_many :contribution_genres, dependent: :destroy
  has_many :genres, through: :contribution_genres
end
