require 'rest-client'

class Request

  BASE = 'https://newsapi.org/v2/'

  KEY = ENV['NEWS_KEY']

  def get_articles_by_category(cat)
    response = RestClient.get(generate_url('top-headlines', 'category', cat))
    JSON.parse(response)["articles"]
  end

  def get_articles_by_keyword(keyword)
    yesterday = Date.yesterday.to_s
    url = generate_url('everything', 'q', keyword)
    response = RestClient.get(url+'&from='+yesterday)
    JSON.parse(response)["articles"]
  end

  def generate_url(type, key, value)
    BASE+type+'?'+key+'='+value+'&apiKey='+KEY+'&language=en'
  end
end
