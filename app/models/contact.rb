class Contact < ApplicationRecord
  enum subject: { request: 0, stop_request: 1, other: 2 }

  validates :name, presence: true
  validates :message, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
end
