class TopTravelDestinations::CLI
    BASE_PATH = "https://www.tripadvisor.com"

    def call
        create_list
        puts "loading..."
        add_attributes_to_dest
        list_destinations
        menu
    end
    
    def create_list
        destinations_array = TopTravelDestinations::Scraper.scrape_main_page(BASE_PATH + '/TravelersChoice-Destinations-cTop-g1')
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
            puts ""
            puts "Enter the number of the destination you'd like to know more about, type list for the original list, type display to display by continent, or exit:"
            input = gets.strip.downcase
            
            if input.to_i.between?(1, 25)
                destination_details(input.to_i - 1)
            elsif input == "display"
                list_by_continent
            elsif input == "list"
                list_destinations
            elsif input == "exit"
                puts ""
                puts "Thank you! Safe travels."
            else
                puts "Not sure what you mean."
                puts ""
                menu
            end 
        end
    end

    def destination_details(input)
        index = @destinations[input]
        puts index.location
        puts "---"
        puts "Why visit? #{index.description}"
        puts "http://www.visitgreece.gr/en/greek_islands/crete" if index.description == ""
        puts "---" unless index.description == ""
        puts "Don't miss:" unless index.attractions == []
        index.attractions.each.with_index(1) {|attraction, i| puts "    #{i}. #{attraction}"}
        puts "Current lowest airfare: #{index.flight_price}" unless index.flight_price == nil
        if index.weather_high != ""
            puts "Current local weather:"
            puts "    High: #{index.weather_high.match(/[^°]*/)}°"
            puts "    Low: #{index.weather_low.match(/[^°]*/)}°"
        end
        puts "-----------"
    end

    def list_by_continent
        puts "Africa, Asia, Europe, North America, South America, or Oceania?"
        input = gets.strip
        
        africa = ["Morocco"]
        asia = ["Indonesia", "Cambodia", "Thailand", "Vietnam", "Turkey", "Russia", "United Arab Emirates", "Nepal"]
        europe = ["United Kingdom", "France", "Italy", "Greece", "Spain", "Czech Republic", "Turkey", "Russia"]
        north_america =["New York", "Jamaica", "Bay Islands", "Belize Cayes", "St. Martin", "Mexico", "Cayman Islands"]
        south_america = ["Brazil", "Peru"]
        oceania = ["Society Islands"]

        case input.strip.downcase
        when "africa"
            puts ""
            puts "        Africa"
            puts "-----------------------"
            @destinations.each.with_index(1) do |destination, i| 
                puts "#{i}. #{destination.location}" if africa.include?(destination.location.split(", ")[1])
            end
            puts "-----------------------"
        when "asia"
            puts ""
            puts "             Asia" 
            puts "---------------------------------"
            @destinations.each.with_index(1) do |destination, i| 
                puts "#{i}. #{destination.location}" if asia.include?(destination.location.split(", ")[1])
            end
            puts "---------------------------------"
        when "europe"
            puts "          Europe"
            puts "--------------------------"
            @destinations.each.with_index(1) do |destination, i| 
                puts "#{i}. #{destination.location}" if europe.include?(destination.location.split(", ")[1])
            end
            puts "--------------------------"
        when "north america"
            puts "          North America"
            puts "--------------------------------"
            @destinations.each.with_index(1) do |destination, i| 
                array_size = destination.location.split(/, |-/).length
                if north_america.include?(destination.location.split(/, |-/)[array_size - 1])
                    puts "#{i}. #{destination.location}"
                end
                
            end
            puts "--------------------------------"
        when "south america"
            puts "South America"
            puts "----------------------------"
            @destinations.each.with_index(1) do |destination, i| 
                puts "#{i}. #{destination.location}" if south_america.include?(destination.location.split(", ")[1])
            end
            puts "----------------------------"
        when "oceania"
            puts "Oceania"
            @destinations.each.with_index(1) do |destination, i| 
                puts "#{i}. #{destination.location}" if oceania.include?(destination.location.split(", ")[1])
            end
            puts "*Technically, the Society Islands are not associated with a continent, but  with the region of Oceania."
        end
    end

end