
class Clean

  def clear_old
    old_articles = Article.all.select do |article|
      article.published_at < 1.week.ago
    end
    Article.delete(id: old_articles.map(&:id))
    ArticleTopic.delete(article_id: old_articles.map(&:id)
  end
end
