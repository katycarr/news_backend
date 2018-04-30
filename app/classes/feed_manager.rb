
class FeedManager

  CAT = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology']

  def pull_stories
    req = Request.new
    response = []
    CAT.each do |cat|
      response << req.get_articles_by_category(cat)
    end
    response.flatten!
    response.uniq!

    scrape_and_create(response)
  end

  def get_categories(article_text)
    categorizer = Categorizer.new
    topics = categorizer.get_concepts(article_text)
    topic_ids = []
    if topics
      urls = topics[:concepts].map { |topic| topic[0].to_s }
      existing_topics = Topic.where(url: urls)
      existing_urls = existing_topics.map(&:url)
      if existing_topics.length > 0
        topic_ids << existing_topics.map(&:id)
      end
      new_topics = topics[:concepts].select do |concept|
        !existing_urls.include?(concept.to_s)
      end
      if new_topics.length > 0
        new_topics.each do |concept|
          @topic = Topic.create(name:concept[1][:surfaceForms][0][:string], url:concept[0].to_s)
          topic_ids << @topic.id
        end
      end
    end
    topic_ids.flatten!
  end

  def scrape_and_create(response)
    scr = Scraper.new
    urls = response.map {|article| article["url"]}
    existing_articles = []
    response.each do |article|
      match = Article.find_by(title: article["title"])
      if match && article["source"]["name"] == match.source
        existing_articles << article
      end
    end

    if existing_articles.length != response.length
      new_articles = response.select {|article| !existing_articles.include?(article)}

      articles_to_create = []
      new_articles.each do |article|
        match = articles_to_create.find do |article_data|
          article_data["title"] == article["title"] && article["source"]["name"] == article_data["source"]["name"]
        end
        if !match
          articles_to_create << article
        end
      end
    end

    if articles_to_create && articles_to_create.length > 0
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
        if article_topics
          hashes = article_topics.map do |topic|
            {article_id: @article.id, topic_id: topic}
          end
          ArticleTopic.import hashes
        end
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
