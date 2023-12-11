class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :first_name
      t.string :last_name
      t.string :card_number
      t.integer :cvv
      t.integer :exp_month
      t.integer :exp_year
      t.references :user, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
