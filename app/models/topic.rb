class Topic < ApplicationRecord
  has_many :user_topics

  has_many :article_topics
  has_many :articles, through: :article_topics
end
