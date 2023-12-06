class AddAttributesToRental < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :rentalLength, :time
    add_column :rentals, :cost, :decimal, precision: 10, scale: 2
  end
end
