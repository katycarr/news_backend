class ArticlesController < ApplicationController

  def index
    @articles = paginate(params)
    render json: @articles
  end

  def getnew
    Clean.new.clear_old
    FeedManager.new.pull_stories(loggedin_user.topics)
    @articles = paginate(params)
    render json: @articles
  end

end
