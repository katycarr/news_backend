
class Clean

  def clear_old
    old_articles = Article.all.select do |article|
      article.published_at < 2.days.ago
    end
    Article.where(id: old_articles.map(&:id)).delete_all
    Reading.where(article_id: old_articles.map(&:id)).delete_all
    old_article_topics = ArticleTopic.where(article_id: old_articles.map(&:id))

    Topic.where(id: old_article_topics.map(&:topic_id)).delete_all
    ArticleTopic.where(id: old_article_topics.map(&:id)).delete_all
  end
end
