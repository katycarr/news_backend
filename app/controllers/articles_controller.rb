class ArticlesController < ApplicationController

  def index
    # Clean.new.clear_old
    # FeedManager.new.query_all(loggedin_user.topics)

    @articles = Funnel.new.select(loggedin_user)
    sorted_articles = @articles.sort {|a, b| b.published_at <=> a.published_at }
    render json: sorted_articles.first(20)
  end
end
