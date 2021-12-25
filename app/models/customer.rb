class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :contributions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :customer_image

  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   customer = Customer.where(email: data['email']).first


  #   unless customer
  #       customer = Customer.create(
  #         last_name: data['family_name'],
           
  #           # last_name: data['last_name'],
  #           first_name: data['first_name'],
  #           email: data['email'],
  #           password: Devise.friendly_token[0,20]
  #       )
  #   end
  #   customer
  # end
  
  
  
  
  
  def self.find_or_create_for_oauth(auth)
    find_or_create_by!(email: auth.info.email) do |customer|
      customer.provider = auth.provider
      customer.uid = auth.uid
      customer.name = auth.info.name
      customer.email = auth.info.email
      password = Devise.friendly_token[0..5]
      logger.debug password
      customer.password = password
    end
  end

  def new_with_session(params, session)
    if customer_attributes = session['devise.customer_attributes']
      new(customer_attributes) { |customer| customer.attributes = params }
    else
      super
    end
  end




#   def self.from_omniauth(auth)
#   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
#     user.email = auth.info.email
#     user.password = Devise.friendly_token[0,20]
#     user.name = auth.info.name   # assuming the user model has a name
# end
# end




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
