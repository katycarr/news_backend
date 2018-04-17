
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

  def get_categories(article_text)
    categorizer = Categorizer.new
    topics = categorizer.get_concepts(article_text)
    topic_ids = []
    if topics
      urls = topics[:concepts].map
      topics[:concepts].each do |concept|
        @topic = Topic.find_or_create_by(name:concept[1][:surfaceForms][0][:string], url:concept[0].to_s)
        topic_ids << @topic.id
      end
    end
    topic_ids
  end

  def scrape_and_create(response)
    scr = Scraper.new
    urls = response.map {|article| article["url"]}
    existing_articles = Article.where(url: urls).map(&:url)
    if urls.size != existing_articles.size
      articles_to_create = response.select {|article| !existing_articles.include?(article["url"])}
    end
    if articles_to_create
      articles_to_create.each do |article|
        text = scr.scrape(article["url"])
        @article = Article.create(
          title: article["title"],
          author: article["author"],
          source: article["source"]["name"],
          url: article["url"],
          description: article["description"],
          published_at: article["publishedAt"],
          img_url: article["urlToImage"],
          text: text
        )
        article_topics = get_categories(text)
        hashes = article_topics.map do |topic|
          {article_id: @article.id, topic_id: topic}
        end
        ArticleTopic.import hashes
      end
    end
  end

  def query_all(user_topics)
    response = []
    user_topics.each do |topic|
      response << query_stories(topic.name)
    end
    response.flatten!
    scrape_and_create(response)
  end

  def query_stories(topic_name)
    req = Request.new
    split_name = topic_name.gsub(/[^0-9a-z ]/i, '').split(' ')
    joined = split_name.join(' OR ')
    response = req.get_articles_by_keyword(joined)
  end
end
