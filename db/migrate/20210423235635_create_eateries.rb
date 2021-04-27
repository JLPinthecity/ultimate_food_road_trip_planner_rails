class CreateEateries < ActiveRecord::Migration[6.1]
  def change
    create_table :eateries do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :food_categories
      t.text :about
      t.string :dishes

      t.timestamps
    end
  end
end