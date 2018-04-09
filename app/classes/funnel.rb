
class Funnel

  def select(user)
    topics = user.topics
    # chosen_articles = []
    topic_ids = topics.map { |topic| topic.id }
    article_topics = ArticleTopic.where(topic_id: topic_ids)
    article_ids = article_topics.map {|at| at.article_id}
    chosen_articles = Article.where(id: article_ids)
  end

end
