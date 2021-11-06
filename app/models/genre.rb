class Genre < ApplicationRecord
  has_many :contribution_genres, dependent: :destroy
end
