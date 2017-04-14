require 'nokogiri'
require 'open-uri'

class TopTravelDestinations::Scraper

    def self.scrape_page
        page = Nokogiri::HTML(open("https://www.tripadvisor.com/TravelersChoice-Destinations-cTop-g1"))
        
        destinations = []
        page.css(".posRel tcInner tcActive").each do |destination|
            destinations << {
                :location => destination.css(".mainName a").text,
                :description => destination.css(".descr_lb").text,
                :attractions => [
                    destination.css(".dontmiss li").each do |item|
                        item.css("a").text
                    end
                ],
                :attractions_url => destination.css(".allattr a")["href"]
            }
        end
        destinations
    end

end