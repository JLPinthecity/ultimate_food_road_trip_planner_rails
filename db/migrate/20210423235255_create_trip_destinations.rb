class CreateTripDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :trip_destinations do |t|
      t.integer :trip_id
      t.integer :destination_id
      t.timestamps
    end
  end
end
