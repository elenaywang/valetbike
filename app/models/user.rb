class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :rentals, class_name: :Rental, foreign_key: :borrower_id
  has_many :rentals, foreign_key: :borrower_id
  # has_many :borrowed_bikes, through: :rentals
  
  # has_one :payment
end
