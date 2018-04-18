class User < ApplicationRecord
  has_secure_password

  has_many :readings
  has_many :user_topics
  has_many :topics, through: :user_topics

  def articles
    topic_ids = self.topics.map { |topic| topic.id }
    article_topics = ArticleTopic.where(topic_id: topic_ids)
    article_ids = article_topics.map {|at| at.article_id}
    article_ids.uniq!
    chosen_articles = Article.where(id: article_ids).reorder(published_at: :desc)
  end
end
