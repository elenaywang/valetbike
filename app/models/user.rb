class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :phone_number, length: {is: 10}, numericality: {only_integer: true, message: "is not a number"}

  has_many :rentals, foreign_key: :borrower_id

  has_one :payment, dependent: :destroy

end
