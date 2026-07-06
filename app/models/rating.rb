class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating,
            presence: true,
            inclusion: { in: 1..5 }

  validates :user_id,
            uniqueness: {
              scope: :product_id,
              message: "has already rated this product"
            }
end