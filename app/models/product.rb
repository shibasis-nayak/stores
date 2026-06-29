class Product < ApplicationRecord
  belongs_to :category, optional: true


  has_many_attached :images
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :description, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "name",
      "description",
      "price",
      "created_at",
      "updated_at"
    ]
  end

end