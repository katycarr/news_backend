class Article < ApplicationRecord
  has_many :article_topics
  has_many :topics, through: :article_topics
  has_many :readings

  def text=(article_text)
    
    if !article_text.empty?
      self.reading_time = Timer.new.get_time(article_text)
      self.emotion = Watson.new.get_emotion(article_text)
    end
  end
end
