class CreateEateriesTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :eateries_trips do |t|
      t.integer :user_id
      t.integer :trip_id
      t.boolean :visited
      t.timestamps
    end
  end
end
