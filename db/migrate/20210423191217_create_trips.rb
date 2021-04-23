class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
