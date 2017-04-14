require 'nokogiri'
require 'open-uri'

class TopTravelDestinations::Scraper

    def self.scrape_main_page
        page = Nokogiri::HTML(open("https://www.tripadvisor.com/TravelersChoice-Destinations-cTop-g1"))
        
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
            :attractions => page.css(".col.attractions li .name").collect {|attr| attr.text.strip},
            :attractions_url => "https://www.tripadvisor.com#{page.css(".col.attractions .seeAllLink").attribute("href").value}"
        }

        destination_info[:attractions] << page.css(".col.attractions li .name").each {|attr| attr.text.strip},
    end

end