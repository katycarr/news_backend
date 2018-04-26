class Topic < ApplicationRecord
  has_many :user_topics

  has_many :article_topics
  has_many :articles, through: :article_topics

  def article_count
    ArticleTopic.where(topic_id: self.id).count
  end

  def user_count
    UserTopic.where(topic_id: self.id).count
  end
end
