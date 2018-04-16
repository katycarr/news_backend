require 'nokogiri'
require 'readability'
require 'rest-client'

class Scraper

  def scrape(url)
    begin
      page = RestClient.get(url)
    rescue => err 
    else
      page
    end
    content = Readability::Document.new(page).content
    parse_page = Nokogiri::HTML(content)
    paragraph_array = []
    parse_page.css('p').map do |p|
      paragraph = p.text
      paragraph_array.push(paragraph)
    end
    full_text = paragraph_array.join(' ')

  end
end
