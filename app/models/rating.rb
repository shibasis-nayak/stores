class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating,
            presence: true,
            inclusion: { in: 1..5 }

  validates :review,
            presence: true,
            length: { minimum: 10, maximum: 500 }
end