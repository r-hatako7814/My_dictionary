class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :contributions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :customer_image

  def already_favorited?(contribution)
    favorites.where(contribution_id: contribution.id).exists?
  end

  def active_for_authentication?
    super && (!self.is_deleted)
  end
end
