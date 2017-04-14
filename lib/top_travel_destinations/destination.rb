class TopTravelDestinations::Destination

    attr_accessor :location, :description, :attractions, :attractions_url, :flight_price

    @@all = []

    def initialize(destination_hash)
        destination_hash.each do |key, value|
            self.send("#{key}=", value)
        end
        self.class.all << self
    end

    def self.all
        @@all
    end

end