class Rental < ApplicationRecord

    validates_uniqueness_of :return, scope: :borrower_id        # prevents user from making multiple rentals at once

    belongs_to :borrower, class_name: :User, foreign_key: :borrower_id
    belongs_to :bike, class_name: :Bike, foreign_key: :bike_id

    def duration
        unless self.return.blank?
          (self.return - self.checkout).div(60)   # Returns duration in minutes
        end
    end
    
end
