require 'nokogiri'
require 'open-uri'

class TopTravelDestinations::Scraper

    def self.scrape_main_page(main_page_url)
        page = Nokogiri::HTML(open(main_page_url))

        destinations = page.css(".mainName a").collect do |destination|
             {
                :location => destination.text,
                :destination_url => "https://www.tripadvisor.com#{destination.attribute("href").value}"
            }
        end
        TopTravelDestinations::Destination.create_from_collection(destinations)
    end

    def self.scrape_destination_page(destination_url)
        page = Nokogiri::HTML(open(destination_url))
        description_html = page.css("#taplc_expanding_read_more_box_0 .content")
        attractions_html = page.css(".col.attractions li .name")
        weather_high_html = page.css(".temps.wrap span.high")
        weather_low_html = page.css(".temps.wrap span.low")
        flight_price_html = page.css(".flightPrices.wrap .price")

        destination_info = {
            :description => (description_html.text.strip if description_html.text != ""),
            :attractions => (attractions_html.collect {|a| a.text.strip} if attractions_html != []),
            :weather_high => (weather_high_html.text if weather_high_html != ""),
            :weather_low => (weather_low_html.text if weather_low_html != ""),
            :flight_price => (flight_price_html.text.strip.match(/[$][^$]*/) if flight_price_html)       
        }
    end

end