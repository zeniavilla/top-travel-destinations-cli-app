class TopTravelDestinations::CLI

    def call
        create_list
        puts "\nloading..."
        add_attributes_to_dest
        list_destinations
        menu
    end
    
    def create_list
        destinations_array = TopTravelDestinations::Scraper.scrape_main_page('https://www.tripadvisor.com/TravelersChoice-Destinations-cTop-g1')
        TopTravelDestinations::Destination.create_from_collection(destinations_array)
    end

    def add_attributes_to_dest
        @destinations = TopTravelDestinations::Destination.all
        @destinations.each do |destination|
            attributes = TopTravelDestinations::Scraper.scrape_destination_page(destination.destination_url)
            destination.add_attributes(attributes)
        end
    end

    def list_destinations
        puts ""
        puts "Top Travel Destinations"
        puts "-----------------------"
        @destinations.each.with_index(1) {|destination, i| puts "#{i}. #{destination.location}"}
    end

    def menu
        input = ""
        while input != "exit"
            puts "\nEnter the number of the destination you'd like to know more about, type list for the original list, type display to display by continent, or exit:"
            input = gets.strip.downcase
            
            if input.to_i.between?(1, 25)
                destination_details(input.to_i - 1)
            elsif input == "display"
                list_by_continent
            elsif input == "list"
                list_destinations
            elsif input == "exit"
                puts "\nThanks for using Top Travel Destinations! Safe travels.\n"
            else
                puts "\nNot sure what you mean.\n"
                menu
            end 
        end
    end

    def destination_details(input)
        index = @destinations[input]

        puts "\n#{index.location}\n"
        puts "\nWhy visit?"
        puts "\n#{index.description}"
        puts "http://www.visitgreece.gr/en/greek_islands/crete" if index.description.nil?
        puts "\nDon't miss:" unless index.attractions == []
        index.attractions.each.with_index(1) {|attraction, i| puts "    #{i}. #{attraction}"}
        puts "\nCurrent lowest airfare: #{index.flight_price}" unless index.flight_price == nil
        if index.weather_high != ""
            puts "\nCurrent local weather:"
            puts "   High: #{index.weather_high.match(/[^°]*/)}°"
            puts "   Low: #{index.weather_low.match(/[^°]*/)}°"
        end
    end

    def list_by_continent
        puts "\nAfrica, Asia, Europe, North America, South America, or Oceania?"
        continent_input = gets.strip

            puts "\n#{continent_input.split(" ").map {|word| word.capitalize}.join(" ")
}"
            puts "----------------------------------"
            africa_destinations = TopTravelDestinations::Destination.find_by_continent(continent_input)
            africa_destinations.each do |destination| 
                puts "#{TopTravelDestinations::Destination.all.find_index(destination) + 1}. #{destination.location}"
            end
            puts "----------------------------------"
            puts "*Technically, the Society Islands are not associated with a continent, but with the region of Oceania." if continent_input.downcase == "oceania"
    end

end