class AddReviewToRatings < ActiveRecord::Migration[8.1]
  def change
    add_column :ratings, :review, :text
  end
end
