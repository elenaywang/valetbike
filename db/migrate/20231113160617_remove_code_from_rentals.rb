class RemoveCodeFromRentals < ActiveRecord::Migration[7.0]
  def change
    remove_column :rentals, :used_one_time_codes, :text
  end
end
