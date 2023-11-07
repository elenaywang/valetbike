class User < ApplicationRecord
    validates_presence_of   :username

    #has_many :rentals has_many :borrowed_bikes, through: :rentals
end
