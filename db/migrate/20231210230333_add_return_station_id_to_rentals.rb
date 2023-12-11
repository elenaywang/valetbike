class AddReturnStationIdToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :return_station_id, :integer
  end
end
