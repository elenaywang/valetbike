namespace :db do 
    desc "import station data from csv file"

    task :import_stations, [:filename] => :environment do |task, args|
        require 'csv'

        puts "importing station data..."

        CSV.parse(File.read(args[:filename]), headers: true).each do |row|
            puts "importing: station #{row.to_hash["name"]}\n"
            import_station(row.to_hash)
        end
    end

    def import_station(item)
        station = Station.new({
            identifier: item["identifier"],
            name:       item["name"],
            address:    item["address"]})
        
            
        if station.save
            puts "successfully imported: station #{item["name"]}\n"
        else 
            puts "failed to import: station #{item["name]}\n"]}"
        end
    end
end
