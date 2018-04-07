require 'rest-client'

class Request

  BASE = 'https://newsapi.org/v2/top-headlines'
  KEY = ENV['NEWS_KEY']

  def get_articles(cat)
    response = RestClient.get(generate_url(cat))
    JSON.parse(response)["articles"]
  end

  def generate_url(category)
    BASE+'?category='+category+'&apiKey='+KEY
  end
end
