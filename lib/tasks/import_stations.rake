# task imports station data from a csv file 
# use before importing bike data
# rake db:import_stations["notes/station-data.csv"]
# rails db:seed

namespace :db do
    desc "Import station data from csv file"
    task :import_stations, [:filename] => :environment do |task, args|
        require 'csv'

        puts "Importing station data"

        CSV.parse(File.read(args[:filename]), headers: true).each do |row|
            puts "Importing: #{row.to_hash["identifier"]}\n"

            import_station(row.to_hash)
        end
    end

    def import_station(item)
        station = Station.new({ identifier: item["identifier"], name: item["name"], address: item["address"] })

        if station.save
            puts "Successfully imported: #{item["name"]}\n"
        else
            puts "Failed to import: #{item["name"]}\n"
        end
    end
end