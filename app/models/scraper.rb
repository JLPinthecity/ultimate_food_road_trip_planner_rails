require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 

  def scrape_road_foods   
    roadfood_url = "https://roadfood.com/guides/page/3/"
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

       guide_title = doc.css(".entry-header").css("h1").text
       description = doc.css("p")[2].text
       eateries = doc.css(".restaurant.hbox")

       create_trips(guide_title, description, eateries)
      
    end
  end

  def create_trips(guide_title, description, eateries)
    trips = []
    eateries.each do |eatery|
    
        city_state = eatery.css(".rf-restaurant-location.vbox-item").text.gsub("\n", " ").gsub("\t", " ").gsub(/\s+/, "")
        city = city_state.split(",")[0]
        state = city_state.split(",")[1]
        restaurant_name = eatery.css(".entry-title").css("a").text
        food_categories = eatery.css(".rf-food-categories").css("a").text.split(/(?<=\p{Ll})(?=\p{Lu})|(?<=\p{Lu})(?=\p{Lu}\p{Ll})/)
        dishes = eatery.css(".rf_dish_list").text.gsub("\n", " ").gsub("\t", " ").gsub!(/ +?,/, ',').gsub(/\s+/, ' ')
        about = eatery.css(".rf-restaurant-preview").css("p").text
    
        trip = {
            :title => guide_title,
            :description => description,
            :destination => { 
                :city => city_state.split(",")[0],
                :state => city_state.split(",")[1],
        }
    }

        trip[:destination][:eateries] = make_eateries(restaurant_name, food_categories, dishes, about)

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




