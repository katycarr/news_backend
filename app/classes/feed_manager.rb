
class FeedManager

  CAT = ['business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology']

  def pull_stories(topics)
    req = Request.new
    response = []
    CAT.each do |cat|
      response << req.get_articles_by_category(cat)
    end
    response << query_all(topics)
    unique_sources = uniq_by_title_and_source(response.flatten)
    scrape_and_create(unique_sources)
  end

  def reduce_to_title_and_source(array)
    array.map {|res| {title: res["title"], source_name: res["source"]["name"] }}
  end

  def uniq_by_title_and_source(array)
    unique = []
    array.each do |el|
      el_hash = reduce_to_title_and_source([el])[0]
      if !reduce_to_title_and_source(unique).include?(el_hash)
        unique << el
      end
    end
    unique
  end

  def get_categories(article_text)
    categorizer = Categorizer.new
    topics = categorizer.get_concepts(article_text)
    topic_ids = []
    if topics
      topics[:concepts].each do |concept|
        @topic = Topic.find_by(url: concept[0].to_s)
        if !@topic
          @topic = Topic.create(name:concept[1][:surfaceForms][0][:string], url:concept[0].to_s)
        end
        topic_ids << @topic.id
      end
    end
    topic_ids
  end

  def find_new_articles(article_array)
    uncreated = article_array.select do |article|
      !Article.find_by(title: article["title"], source: article["source"]["name"])
    end
  end

  def scrape_and_create(response)
    scr = Scraper.new
    new_articles = find_new_articles(response)
    if new_articles && new_articles.length > 0
      new_articles.each do |article|
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
    unique_data = uniq_by_title_and_source(response.flatten)
    unique_data
  end



  def query_stories(topic_name)
    req = Request.new
    split_name = topic_name.gsub(/[^0-9a-z ]/i, '').split(' ')
    joined = split_name.join(' OR ')
    response = req.get_articles_by_keyword(joined)
  end
end
