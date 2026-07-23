class RemoveUniqueIndexFromRatings < ActiveRecord::Migration[8.1]
  def change
    remove_index :ratings,
                 column: [ :user_id, :product_id ]
  end
end
