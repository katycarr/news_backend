require 'rest-client'

class Request

  BASE = 'https://newsapi.org/v2/'

  KEY = ENV['NEWS_KEY']

  def get_articles_by_category(cat)
    last_week = 1.week.ago.to_date.to_s
    url = generate_url('top-headlines', 'category', cat)
    response = RestClient.get(url+'&from='+last_week+'&country=us')
    JSON.parse(response)["articles"]
  end

  def get_articles_by_keyword(keyword)
    yesterday = Date.yesterday.to_s
    url = generate_url('everything', 'q', keyword)
    response = RestClient.get(url+'&from='+yesterday+'&language=en')
    JSON.parse(response)["articles"]
  end

  def generate_url(type, key, value)
    BASE+type+'?'+key+'='+value+'&apiKey='+KEY
  end
end
