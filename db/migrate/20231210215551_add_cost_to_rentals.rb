class AddCostToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :cost, :float
  end
end
