class TopTravelDestinations::Destination
    attr_accessor :location, :description, :destination_url, :attractions, :attractions_url, :flight_price

    @@all = []

    def initialize(destination_hash)
        destination_hash.each do |key, value|
            self.send("#{key}=", value)
        end
        self.class.all << self
    end

    def self.create_from_collection(destinations_array)
        destinations_array.each {|destination| d = TopTravelDestinations::Destination.new(destination)}
    end

    def add_attributes(attributes_hash)
        attributes_hash.each do |key, value|
            self.send("#{key}=", value)
        end
    end

    def self.all
        @@all
    end

end