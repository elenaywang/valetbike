class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.integer :borrower_id
      t.integer :bike_id
      t.integer :station_id
      t.datetime :checkout
      t.datetime :return

      t.timestamps
    end
  end
end
