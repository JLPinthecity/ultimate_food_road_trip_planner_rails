require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 

  def scrape_road_foods   
    roadfood_url = "https://roadfood.com/guides"
    html = open(roadfood_url)
    doc = Nokogiri::HTML(html)
    guides = doc.css(".guides.rf-grid-list").css("li")
    guide_urls = []
    guides.each do |guide|
      url = guide.css("div.rf-grid-tile-thumb").css("a").attr("href").value
      guide_urls << url
    end
    scrape_guide_pages(guide_urls)
  end

  def scrape_guide_pages(guide_urls)
    guide_urls.each do |guide_url|
       url = guide_url
       html = open(url)
       doc = Nokogiri::HTML(html)
       trip_title = doc.css("title").text
       destinations = doc.css(".restaurant.hbox")
       description = doc.css('p')[2].text

       create_trips(trip_title, destinations, description)
    end
  end

  def create_trips(trip_title, destinations, description)
    trips = []

    eateries = []
    destinations.each do |destination|
        city_state = destination.css(".rf-restaurant-location.vbox-item").text.gsub("\n", " ").gsub("\t", " ").gsub(/\s+/, "")
        restaurant_name = destination.css(".entry-title").css("a").text
        food_categories = destination.css(".rf-food-categories").css("a").text.split(/(?<=\p{Ll})(?=\p{Lu})|(?<=\p{Lu})(?=\p{Lu}\p{Ll})/)
        dishes = destination.css(".rf_dish_list").text.gsub("\n", " ").gsub("\t", " ").strip
        about = destination.css(".rf-restaurant-preview").css("p").text
    
     

        trip = {
            :title => city_state,
            :description => description,
            :destinations => { 
                :city => city_state.split(",")[0],
                :state => city_state.split(",")[1],
        }
    }

        trip[:destinations][:eateries] = make_eateries(restaurant_name, food_categories, dishes, about)

        trips << trip
    end
    binding.pry
  end

  def make_eateries(restaurant_name, food_categories, dishes, about)
    eateries = [] 
    eatery = { 
        :name => restaurant_name,
        :food_categories => food_categories,
        :about => about,
        :dishes => dishes
   }
    eateries << eatery
  end
  
end

scrape = Scraper.new
scrape.scrape_road_foods




