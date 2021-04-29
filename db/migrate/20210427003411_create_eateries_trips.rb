class CreateEateriesTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :eateries_trips do |t|
      t.integer :eatery_id
      t.integer :trip_id
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
