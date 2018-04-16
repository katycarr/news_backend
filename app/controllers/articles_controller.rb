class ArticlesController < ApplicationController

  def index
    @articles = loggedin_user.articles
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
    old_article_ids = loggedin_user.articles.map {|article| article.id}
    FeedManager.new.query_all(loggedin_user.topics)
    FeedManager.new.pull_stories
    new_articles = loggedin_user.articles.select { |article| !old_article_ids.include?(article.id)}
    render json: new_articles
  end

end
