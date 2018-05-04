class Article < ApplicationRecord
  has_many :article_topics
  has_many :topics, through: :article_topics
  has_many :readings

  def text=(article_text)

    if !article_text.empty?
      self.reading_time = Timer.new.get_time(article_text)
      # self.emotion = Watson.new.get_emotion(article_text)
    end
  end

  def self.dedupe
    # find all models and group them on keys which should be common
    grouped = all.group_by{|article| [article.title,article.source] }
    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # or pop for last one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy} # duplicates can now be destroyed
    end
  end

  def self.duplicates?
    matching_titles = all.select(:title).group(:title).having("count(*) > 1")
    bad = []
    matching_titles.each do |title|
      sources = self.where(title: title).map(&:source)
      if sources.length != sources.uniq.length
        bad << title
      end
    end
    bad
  end
end
