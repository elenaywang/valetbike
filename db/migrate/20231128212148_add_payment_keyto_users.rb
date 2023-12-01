class AddPaymentKeytoUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :payment, foreign_key: true 
  end
end
