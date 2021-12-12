class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :contributions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :customer_image
  
  def self.from_omniauth(access_token)
    data = access_token.info
    customer = Customer.where(email: data['email']).first

    # Uncomment the section below if you want customers to be created if they don't exist
    # unless customer
    #     customer = Customer.create(name: data['name'],
    #        email: data['email'],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    customer
  end
  
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
