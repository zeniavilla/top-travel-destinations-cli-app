class TopTravelDestinations::CLI

    def call
        list_destinations
        menu
    end

    def list_destinations
        puts "Top Travel Destinations"
        puts <<-DOC.gsub /^\s*/, ''
        1. Bali, Indonesia
        2. London, United Kingdom
        3. Paris, France
        4. Rome, Italy
        5. New York City, New York
        ...
        DOC
    end

    def menu
        input = ""
        while input != "exit"
            puts "Enter the number of the destination you'd like to know more about, type display to display by continent, or exit:"
            input = gets.strip.downcase
            
            if input.to_i.between?(1, 25)
                destination_details
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

    def destination_details
        puts <<-DOC.gsub /^\s*/, ''
        [DESTINATION] Bali, Indonesia
        ---
        [DESCRIPTION] Why visit: Bali is a living postcard, an Indonesian paradise that feels like a fantasy. Soak up the sun on a stretch of fine white sand, or commune with the tropical creatures as you dive along coral ridges or the colorful wreck of a WWII war ship. On shore, the lush jungle shelters stone temples and mischievous monkeys. The “artistic capital” of Ubud is the perfect place to see a cultural dance performance, take a batik or silver-smithing workshop, or invigorate your mind and body in a yoga class.
        [ATTRACTIONS]Don't miss:
        1. Waterbom Bali
        2. Mayong Village Tracking Experience
        3. Tirta Gangga
        [ALL ATTRACTIONS URL]Link to all [num] of things to do: https://www.tripadvisor.com/Attractions-g294226-Activities-Bali.html
        DOC
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