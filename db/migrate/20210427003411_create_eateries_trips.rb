class CreateEateriesTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :eateries_trips do |t|
      t.integer :eatery_id
      t.integer :trip_id
      t.datetime :start_date
      t.datetime :end_date
      t.text :notes
      t.timestamps
    end
  end
end
