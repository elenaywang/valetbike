class Rental < ApplicationRecord

    validates_uniqueness_of :return, scope: :borrower_id        # prevents user from making multiple rentals at once
    # validates :station_has_bikes <- check syntax

    belongs_to :borrower, class_name: :User, foreign_key: :borrower_id
    belongs_to :bike, class_name: :Bike, foreign_key: :bike_id

    # private

    # def station_has_bikes
    #     # if station.docked_bikes.count or something like that > 0
    #         # flash[:notice] = 'This station has no bikes. Please choose another station.'
    #     # end
    # end

end
