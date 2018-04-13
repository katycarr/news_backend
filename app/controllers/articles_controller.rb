class ArticlesController < ApplicationController

  def index
    @articles = Funnel.new.select(loggedin_user)
    if params[:start]
      start = params[:start].to_i
    else
      start = 0
    end
    @articles = @articles[(start..start+19)]
    render json: @articles
  end

  def getnew
    Clean.new.clear_old
    old_article_ids = Funnel.new.select(loggedin_user).map {|article| article.id}
    FeedManager.new.query_all(loggedin_user.topics)
    FeedManager.new.pull_stories
    new_articles = Funnel.new.select(loggedin_user).select { |article| !old_article_ids.include?(article.id)}
    render json: new_articles
  end

end
