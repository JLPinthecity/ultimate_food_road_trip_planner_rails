require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 

  def scrape_road_foods   
    doc = Nokogiri::HTML(URI.open("https://roadfood.com/guides/"))
    guides = doc.css(".guides.rf-grid-list").css("li")
    guide_urls = []
    guides.each do |guide|
      url = guide.css("div.rf-grid-tile-thumb").css("a").attr("href").value
      guide_urls << url
    end
    scrape_guide_pages(guide_urls)
  end

  def scrape_guide_pages(guide_urls)
    trips = []
    
    guide_urls.each do |guide_url|
       doc = Nokogiri::HTML(URI.open("#{guide_url}"))

       guide_title = doc.css(".entry-header").css("h1").text  #9 of them
       description = doc.css("p")[2].text                     #9 of them 
       eateries = doc.css(".restaurant.hbox")

       trip = {
        :title => guide_title,
        :description => description,
    }
    
    trip[:destinations] = create_destinations_and_eateries(trip, eateries)
    
    trips << trip 
    end
    trips
  end

  def create_destinations_and_eateries(trip, eateries)
    # trip has multiple destinations
    trip[:destinations] = []

    eateries.each do |eatery|
        dest = {}
        city_state = eatery.css(".rf-restaurant-location.vbox-item").text.gsub("\n", " ").gsub("\t", " ").split(",")
        city = city_state[0].to_s.strip
        state = city_state[1].to_s.strip.upcase
        restaurant_name = eatery.css(".entry-title").css("a").text
        food_categories = eatery.css(".rf-food-categories").css("a").text.split(/(?<=\p{Ll})(?=\p{Lu})|(?<=\p{Lu})(?=\p{Lu}\p{Ll})/).join(", ")
        dishes = eatery.css(".rf_dish_list").text.gsub("\n", " ").gsub("\t", " ").gsub(/ +?,/, ',').gsub(/\s+/, ' ')
        about = eatery.css(".rf-restaurant-preview").css("p").text
        dest[:city] = city
        dest[:state] = state
        dest[:eateries] = {
            :name => restaurant_name,
            :about => about,
            :food_categories => food_categories,
            :dishes => dishes
        }
        trip[:destinations] << dest
    end
    
    trip[:destinations] 
  end

end




