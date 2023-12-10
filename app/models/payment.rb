class Payment < ApplicationRecord
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :card_number, length: {minimum: 15, maximum: 16, message: "Invalid card number"}, numericality: {only_integer: true, message: "Invalid card number"}
  validates :cvv, length: {is: 3, message: "Invalid CVV"}, numericality: {only_integer: true, message: "Invalid CVV"}
  validates :exp_month, length: {minimum: 1, maximum: 2}, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12}
  validates :exp_year, length: {is: 4}, numericality: { only_integer: true, greater_than_or_equal_to: Time.current.year}
  validate :valid_expiry?
  belongs_to :user, optional: true

  private
  def valid_expiry?
    if exp_year == Time.current.year && exp_month.to_i >= Time.current.month
      true
    elsif exp_year > Time.current.year && exp_month.present?
      true
    else
      errors.add(:base, "Invalid expiry date")
      false
    end
  end



end
