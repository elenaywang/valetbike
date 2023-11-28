class Rental < ApplicationRecord
    belongs_to :borrower, class_name: :User, foreign_key: :borrower_id
    #belongs_to :bike, class_name: :Bike, foreign_key: :game_id
end
