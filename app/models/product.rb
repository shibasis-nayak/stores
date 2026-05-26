class Product < ApplicationRecord

  validates :name,presence: true,uniqueness: true

  validates :price,presence: true

  validates :description,presence: true,uniqueness: true

end
