
class FeedManager

  CAT = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology']

  def pull_stories
    req = Request.new
    response = []
    CAT.each do |cat|
      response << req.get_articles_by_category(cat)
    end
    response.flatten!

    scrape_and_create(response)
  end

  def scrape_and_create(response)
    scr = Scraper.new
    
    response.each do |article|
      text = scr.scrape(article["url"])
      @article = Article.find_by(url: article["url"])
      if !@article
        Article.create(
          title: article["title"],
          author: article["author"],
          source: article["source"]["name"],
          url: article["url"],
          description: article["description"],
          published_at: article["publishedAt"],
          img_url: article["urlToImage"],
          text: text
        )
      end
    end
  end

  def query_all(user_topics)
    user_topics.each do |topic|
      query_stories(topic.name)
    end
  end

  def query_stories(topic_name)
    req = Request.new
    split_name = topic_name.gsub(/[^0-9a-z ]/i, '').split(' ')
    joined = split_name.join(' OR ')
    response = req.get_articles_by_keyword(joined)

    scrape_and_create(response)

  end
end
