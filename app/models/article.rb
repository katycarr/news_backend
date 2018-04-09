class Article < ApplicationRecord
  has_many :article_topics
  has_many :topics, through: :article_topics

  def text=(article_text)
    categorizer = Categorizer.new
    topics = categorizer.get_concepts(article_text)
    if topics
      topics[:concepts].each do |concept|
        @topic = Topic.find_or_create_by(name:concept[1][:surfaceForms][0][:string], url:concept[0].to_s)
        self.topics << @topic
      end
    end
    self.reading_time = Timer.new.get_time(article_text)
  end
end
