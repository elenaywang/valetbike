class Payment < ApplicationRecord
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :card_number, length: {minimum: 15, maximum: 16, message: "Please enter a valid card number"}
  validates :card_number, numericality: {only_integer: true, message: "Please enter a valid card number"}
  validates :cvv, length: {is: 3, message: "Please enter a valid CVV"}
  validates :card_number, numericality: {only_integer: true, message: "Please enter a valid CVV"}
  validates :exp_month, length: {minimum: 1, maximum: 2}
  validates :exp_month, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12}
  validates :exp_year, length: {is: 4}
  validates :exp_year, numericality: { only_integer: true, greater_than_or_equal_to: Time.current.year}

  belongs_to :user, optional: true
end
