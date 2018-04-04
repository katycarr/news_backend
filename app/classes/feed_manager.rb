
class FeedManager
  def pull_stories
    req = Request.new
    response = req.get_articles

    scr = Scraper.new
    response["articles"].each do |article|
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
end
