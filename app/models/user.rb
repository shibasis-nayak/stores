class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_one_attached :profile_picture

  has_many :ratings, dependent: :destroy

  has_one :cart, dependent: :destroy
end
