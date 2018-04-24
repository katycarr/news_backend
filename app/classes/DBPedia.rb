class Dbpedia

  BASE = 'http://lookup.dbpedia.org/api/search/KeywordSearch?QueryString='

  def search(term)
    response = RestClient.get(BASE+term, {accept: :json})
    JSON.parse(response)
  end
end
