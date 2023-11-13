class RemoveUsedOneTimeCodesFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :used_one_time_codes, :text
  end
end
