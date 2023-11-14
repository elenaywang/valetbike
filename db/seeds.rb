# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#adds latitude and longitude attributes to station active records (will be helpful when constructing map)
Station.find_by(identifier: "21").update(latitude:42.326020, longitude:-72.633760)
Station.find_by(identifier: "24").update(latitude:42.335860, longitude:-72.673750)
Station.find_by(identifier: "30").update(latitude:42.334600, longitude:-72.645400)
Station.find_by(identifier: "25").update(latitude:42.330109, longitude:-72.652748)
Station.find_by(identifier: "29").update(latitude:42.335820, longitude:-72.667710)
Station.find_by(identifier: "33").update(latitude:42.323889, longitude:-72.652456)
Station.find_by(identifier: "20").update(latitude:42.312646, longitude:-72.647501)
Station.find_by(identifier: "26").update(latitude:42.318106, longitude:-72.634969)
Station.find_by(identifier: "23").update(latitude:42.316766, longitude:-72.635669)
Station.find_by(identifier: "27").update(latitude:42.317868, longitude:-72.632754)
Station.find_by(identifier: "31").update(latitude:42.319833, longitude:-72.631120)
Station.find_by(identifier: "28").update(latitude:42.318811, longitude:-72.626401)
Station.find_by(identifier: "32").update(latitude:42.323250, longitude:-72.626584)
Station.find_by(identifier: "22").update(latitude:42.327683, longitude:-72.650239)
