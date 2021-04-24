require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper 

  def scrape_road_foods   
    roadfood_url = "https://roadfood.com/guides/"
    html = open(roadfood_url)
    doc = Nokogiri::HTML(html)
    guides = doc.css('.rf-grid-tile')
    guide_urls = []
    guides.collect do |guide|
      url = guides.css("li").css("a").attr("href").value
      guide_urls << url
    end
    scrape_guide_pages(guide_urls)
  end

  def scrape_guide_pages(guide_urls)
    binding.pry
  end 
end




