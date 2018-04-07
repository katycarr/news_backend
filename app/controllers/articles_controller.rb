class ArticlesController < ApplicationController

  def index
    # FeedManager.new.pull_stories
    @articles = Funnel.new.select(loggedin_user)
    render json: @articles
  end
end
