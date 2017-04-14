require 'nokogiri'
require 'open-uri'

class TopTravelDestinations::Scraper

    def self.scrape_main_page(main_page_url)
        page = Nokogiri::HTML(open(main_page_url))
        
        destinations = []

        page.css(".mainName a").each do |destination|
            destinations << {
                :location => destination.text,
                :destination_url => "https://www.tripadvisor.com#{destination.attribute("href").value}"
            }
        end
        destinations
    end

    def self.scrape_destination_page(destination_url)
        page = Nokogiri::HTML(open(destination_url))

        destination_info = {
            :description => page.css("#taplc_expanding_read_more_box_0 .content").text.strip,
            :attractions => page.css(".col.attractions li .name").collect {|a| a.text.strip},
            #:attractions_url => page.css(".navLinks .attractions.twoLines a").attribute("href").value
            :flight_price => page.css(".flightPrices.wrap .price").text.strip
        }
    end

end