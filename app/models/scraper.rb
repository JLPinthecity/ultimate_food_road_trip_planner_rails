require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 

  def scrape_road_foods   
    doc = Nokogiri::HTML(URI.open("https://roadfood.com/tours/"))
    guides = doc.css(".section-articles-default.pt-4.tours").css(".col-lg-4.col-6")
    guide_urls = []
    guides.each do |guide|
      
      url = guide.css(".article__image-link").css("a").attr("href").value
      guide_urls << url
    end
    scrape_guide_pages(guide_urls)
  end

  def scrape_guide_pages(guide_urls)
    trips = []
    
    guide_urls.each do |guide_url|
       doc = Nokogiri::HTML(URI.open("#{guide_url}"))
       guide_title = doc.css(".col-lg-8").css("h1").text
       description = doc.css(".section__entry").css("p").text                
       eateries = doc.css(".section-article-single-content").css(".section__row-content.tour-stop-item")

       trip = {
        :title => guide_title,
        :description => description,
    }
    
    trip[:eateries] = create_eateries(trip, eateries)
    trips << trip 
    end
    trips
  end

  def create_eateries(trip, eateries)
    eatery_array = []
    eateries.each do |eatery|
        restaurant = {}
        city_state = eatery.css(".tour__location.mb-3.py-2").text.gsub("\n", " ").gsub("\t", " ").gsub("\r", " ").split(",")
        city = city_state[0].to_s.strip
        state = city_state[1].to_s.strip.upcase
        restaurant_name = eatery.css(".item__title").css("h2").text.gsub("\n", " ").gsub("\t", " ").gsub("\r", " ").strip  
        food_categories = eatery.css(".rf-food-categories").css("a").text.split(/(?<=\p{Ll})(?=\p{Lu})|(?<=\p{Lu})(?=\p{Lu}\p{Ll})/).join(", ")
        dishes = eatery.css(".rf_dish_list").text.gsub("\n", " ").gsub("\t", " ").gsub(/ +?,/, ',').gsub(/\s+/, ' ')
        about = eatery.css(".rf-restaurant-preview").css("p").text
        restaurant = {
            :city => city,
            :state => state,
            :name => restaurant_name,
            :about => about,
            :food_categories => food_categories,
            :dishes => dishes 
        }
        eatery_array << restaurant
        
    end
    return eatery_array
  end
end



# scrape = Scraper.new
# scrape.scrape_road_foods



# #trips = [trip = {}, trip = {}, trip = {
# #title => title, 
# #description => description, 
# #eateries => [{eatery, eatery, eatery}]
# #}]