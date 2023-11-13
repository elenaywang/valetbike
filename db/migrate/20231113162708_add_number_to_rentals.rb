class AddNumberToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :number, :string
  end
end
