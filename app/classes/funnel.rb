
class Funnel

  def select(user)
    topics = user.topics
    chosen_articles = []
    topics.each do |topic|
      chosen_articles << topic.articles
    end
    if chosen_articles != []
      chosen_articles.flatten!.uniq!
    end
    chosen_articles
  end

end
