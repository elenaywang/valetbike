class AddStationId < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :station_id, :integer
  end
end
