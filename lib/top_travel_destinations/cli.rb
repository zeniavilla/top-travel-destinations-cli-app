class TopTravelDestinations::CLI

    def call
        create_list
        list_destinations
        menu
    end
    
    def create_list
        TopTravelDestinations::Scraper.scrape_main_page('https://www.tripadvisor.com/TravelersChoice-Destinations-cTop-g1')
    end

    def add_attributes_to_destination(destination)
        attributes = TopTravelDestinations::Scraper.scrape_destination_page(destination.destination_url)
        destination.add_attributes(attributes)
    end

    def list_destinations
        puts "\nTop Travel Destinations"
        puts "-----------------------"
        TopTravelDestinations::Destination.all.each.with_index(1) {|destination, i| puts "#{i}. #{destination.location}"}
    end

    def menu
        input = ""
        while input != "exit"
            puts "\nEnter the number of the destination you'd like to know more about, type list for the original list, type display to display by continent, or exit:"
            input = gets.strip.downcase
            
            if input.to_i.between?(1, 25)
                destination = TopTravelDestinations::Destination.all[input.to_i - 1]
                add_attributes_to_destination(destination)
                destination_details(destination)
            elsif input == "display"
                list_by_continent
            elsif input == "list"
                list_destinations
            elsif input == "exit"
                puts "\nThanks for using Top Travel Destinations! Safe travels.\n"
                break
            else
                puts "\nNot sure what you mean.\n"
                menu
            end 
        end
    end

    def destination_details(destination)
        puts "\n#{destination.location}\n"
        puts "\nWhy visit?"
        puts "\n#{destination.description}"
        puts "http://www.visitgreece.gr/en/greek_islands/crete" if destination.description.nil?
        puts "\nDon't miss:" unless destination.attractions == []
        destination.attractions.each.with_index(1) {|attraction, i| puts "    #{i}. #{attraction}"}
        puts "\nCurrent lowest airfare: #{destination.flight_price}" unless destination.flight_price == nil
        if destination.weather_high != ""
            puts "\nCurrent local weather:"
            puts "   High: #{destination.weather_high.match(/[^°]*/)}°"
            puts "   Low: #{destination.weather_low.match(/[^°]*/)}°"
        end
    end

    def list_by_continent
        puts "\nAfrica, Asia, Europe, North America, South America, or Oceania?"
        continent_input = gets.strip

            puts "\n#{continent_input.split(" ").map {|word| word.capitalize}.join(" ")
}"
            puts "----------------------------------"
            destinations = TopTravelDestinations::Destination.find_by_continent(continent_input)
            destinations.each do |destination| 
                puts "#{TopTravelDestinations::Destination.all.find_index(destination) + 1}. #{destination.location}"
            end
            puts "----------------------------------"
            puts "*Technically, the Society Islands are not associated with a continent, but with the region of Oceania." if continent_input.downcase == "oceania"
    end

end