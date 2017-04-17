class TopTravelDestinations::Destination
    attr_accessor :location, :description, :destination_url, :attractions, :attractions_url, :flight_price, :weather_high, :weather_low

    @@all = []

    def initialize(destination_hash)
        destination_hash.each do |attribute_name, attribute_value|
            self.send("#{attribute_name}=", attribute_value)
        end
        save
    end

    def self.create_from_collection(destinations_array)
        destinations_array.each {|destination|  TopTravelDestinations::Destination.new(destination)}
    end

    def add_attributes(attributes_hash)
        attributes_hash.each do |attribute_name, attribute_value|
            self.send("#{attribute_name}=", attribute_value)
        end
    end

    def self.find_by_continent(continent)
        continents = {
            :africa => ["Morocco"],
            :asia => ["Indonesia", "Cambodia", "Thailand", "Vietnam", "Turkey", "Russia", "United Arab Emirates", "Nepal"],
            :europe => ["United Kingdom", "France", "Italy", "Greece", "Spain", "Czech Republic", "Turkey", "Russia"],
            :north_america => ["New York", "Jamaica", "Bay Islands", "Belize Cayes", "St. Martin", "Mexico", "Cayman Islands"],
            :south_america => ["Brazil", "Peru"],
            :oceania => ["Society Islands"]
        }
        
        continent_sym = continent.gsub(" ", "_").downcase.to_sym

        self.all.select do |destination|
            array_size = destination.location.split(/, |-/).length
            continents[continent_sym].include?(destination.location.split(/, |-/)[array_size - 1])
        end
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
    end
end