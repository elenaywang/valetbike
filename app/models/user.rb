class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :rentals, foreign_key: :borrower_id

  has_one :payment

  # def has_payment_id?
  #   !self.id.nil? || self.payment_id.nil?
  # end

end
