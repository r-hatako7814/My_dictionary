class Genre < ApplicationRecord
  has_many :contribution_genres, dependent: :destroy
  has_many :contributions, through: :contribution_genres
end
