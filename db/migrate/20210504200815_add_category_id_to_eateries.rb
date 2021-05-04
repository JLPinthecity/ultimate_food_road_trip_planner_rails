class AddCategoryIdToEateries < ActiveRecord::Migration[6.1]
  def change
    add_column :eateries, :category_id, :integer
  end
end
