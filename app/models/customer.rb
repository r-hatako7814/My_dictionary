class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :contributions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :customer_image

  def already_favorited?(contribution)
    favorites.where(contribution_id: contribution.id).exists?
  end

  def active_for_authentication?
    super && (!self.is_deleted)
  end

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
end
