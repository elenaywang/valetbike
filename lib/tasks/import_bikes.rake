namespace :db do 
    desc "import bike data from csv file"

    task :import_bikes, [:filename] => :environment do |task, args|
        require 'csv'

        puts "importing bike data..."

        CSV.parse(File.read(args[:filename]), headers: true).each do |row|
            puts "importing: bike #{row.to_hash["identifier"]}\n"
            import_bike(row.to_hash)
        end
    end

    def import_bike(item)
        bike = Bike.new(identifier: item["identifier"])
        bike.current_station = Station.find_by(identifier: item ["current_station_identifier"])

        if bike.save
            puts "successfully imported: bike #{item["identifier"]}\n"
        else 
            puts "failed to import: bike #{item["identifier]}\n"]}"
        end
    end
end
