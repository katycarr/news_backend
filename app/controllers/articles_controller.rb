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

  private

  def paginate(params)
    @articles = loggedin_user.articles
    if params[:start]
      start = params[:start].to_i
    else
      start = 0
    end
    @articles = @articles[(start..start+19)]
  end

end
