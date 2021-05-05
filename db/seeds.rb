require 'pry'

Trip.destroy_all
Eatery.destroy_all
EateryTrip.destroy_all

scrape = Scraper.new
trips = scrape.scrape_road_foods 
Trip.create_from_collection(trips)
