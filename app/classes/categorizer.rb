

class Categorizer
  APP_ID = ENV["AYLIEN_ID"]
  APP_KEY = ENV["AYLIEN_KEY"]

  def get_concepts(article_text)
    client = AylienTextApi::Client.new(app_id:APP_ID, app_key:APP_KEY)
    client.concepts(text:article_text)
  end


end
