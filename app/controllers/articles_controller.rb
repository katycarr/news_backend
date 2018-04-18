class ArticlesController < ApplicationController

  def index
    @articles = paginate(params)
    render json: @articles
  end

  def getnew
    Clean.new.clear_old
    FeedManager.new.query_all(loggedin_user.topics)
    FeedManager.new.pull_stories
    @articles = paginate(params)
    render json: @articles
  end

end
