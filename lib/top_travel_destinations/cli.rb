class TopTravelDestinations::CLI
    BASE_PATH = "https://www.tripadvisor.com"

    def call
        create_list
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
        puts "Top Travel Destinations"
        
        @destinations.each.with_index(1) {|destination, i| puts "#{i}. #{destination.location}"}
    end

    def menu
        input = ""
        while input != "exit"
            puts "Enter the number of the destination you'd like to know more about, type display to display by continent, or exit:"
            input = gets.strip.downcase
            
            if input.to_i.between?(1, 25)
                destination_details(input.to_i - 1)
            elsif input == "display"
                list_by_continent
            elsif input == "exit"
                puts "Goodbye!"
            else
                puts "Not sure what you mean."
                menu
            end 
        end
    end

    def destination_details(input)
        index = @destinations[input]
        puts index.location
        puts "---"
        puts "Why visit? #{index.description}"
        puts "Don't miss:"
        index.attractions.each.with_index(1) {|attraction, i| puts "#{i}. #{attraction}"}
        puts "Current lowest airfare: #{index.flight_price}" unless index.flight_price == nil
        puts "-----------"
    end

    def list_by_continent
        puts "Africa, Asia, Europe, North America, South America, or Oceania?"
        input = gets.strip
        
        case input.downcase
        when "africa"
            puts <<-DOC
            Africa
            ---------------------
            1.Marrakech, Morocco
            ---------------------
            DOC
        when "asia"
            puts <<-DOC
            Asia 
            -------------------------------
            1. Bali, Indonesia
            2. Siem Reap, Cambodia
            3. Phuket, Thailand
            4. Hoi An, Vietnam
            5. Istanbul, Turkey
            6. St. Petersburg, Russia
            7. Dubai, United Arab Emirates
            8. Kathmandu, Nepal
            -------------------------------
            DOC
        when "europe"
            puts <<-DOC
            Europe
            --------------------------
            1. London, United Kingdom
            2. Paris, France
            3. Rome, Italy
            4. Crete, Greece
            5. Barcelona, Spain
            6. Prague, Czech Republic
            7. Istanbul, Turkey
            8. St. Petersburg, Russia
            --------------------------
            DOC
        when "north america"
            puts <<-DOC
            North America
            --------------------------------
            1. New York City, New York
            2. Jamaica
            3. Roatan, Bay Islands
            4. Ambergris Caye, Balize Cayes
            5. St. Maarten-St. Martin
            6. Playa del Carmen, Mexico
            7. Grand Cayman, Cayman Islands
            --------------------------------
            DOC
        when "south america"
            puts <<-DOC
            South America
            --------------------------
            1. Rio de Janeiro, Brazil
            2. Cusco, Peru
            --------------------------
            DOC
        when "oceania"
            puts <<-DOC
            Oceania
            1. Bora Bora, Society Islands
            *Technically, the Society Islands are not associated with a continent, but  with the region of Oceania.
            DOC
        end
    end
end