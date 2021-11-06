class ContributionGenre < ApplicationRecord
  belongs_to :contribution
  belongs_to :genre
end
