require 'rest-client'

class Request

  BASE = 'https://newsapi.org/v2/top-headlines'
  KEY = ENV['NEWS_KEY']
  CAT = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology']

  def get_articles
    response = RestClient.get(generate_url('business'))
    JSON.parse(response)
  end

  def generate_url(category)
    BASE+'?category='+category+'&country=us&apiKey='+KEY
  end
end
