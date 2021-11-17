class Contribution < ApplicationRecord

  belongs_to :customer
  has_many :contribution_genres, dependent: :destroy
  has_many :genres, through: :contribution_genres
  has_many :favorites, dependent: :destroy
  accepts_nested_attributes_for :contribution_genres

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  def self.search(keyword)
    where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end

  # def self.search_show(keyword)
  #   where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  # end
end
