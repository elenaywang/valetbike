# to import bike data, run the following command in your terminal:
# rake db:import_bikes["notes/bike-data.csv"]
namespace :db do
    desc "Import bike data from csv file"
    task :import_bikes, [:filename] => :environment do |task,args|
        require 'csv'

        puts "Importing bike data"

        CSV.parse(File.read(args[:filename]), headers: true).each do |row|
            puts "Importing: Bike #{row.to_hash["identifier"]}\n"

            import_bike(row.to_hash)
        end
    end

    def import_bike(item)
        bike = Bike.new(identifier: item["identifier"])
        bike.current_station = Station.find_by(identifier: item["current_station_identifier"])

        if bike.save
            puts "Successfully imported: Bike #{item["identifier"]}\n"
        else
            puts "Failed to import: Bike #{item["identifier"]}\n"
        end
    end
end
