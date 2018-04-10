require 'nokogiri'
require 'readability'
require 'rest-client'

class Scraper

  def scrape(url)
    begin
      page = RestClient.get(url)
    rescue RestClient::Unauthorized, RestClient::Forbidden, RestClient::Exceptions::ReadTimeout, Zlib::GzipFile::Error, Errno::ECONNREFUSED, RestClient::NotFound, RestClient::BadGateway => err 
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
