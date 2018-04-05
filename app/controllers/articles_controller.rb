class ArticlesController < ApplicationController

  def index
    # FeedManager.new.pull_stories
    @user = User.find(params[:user_id])
    @articles = Funnel.new.select(@user)
    render json: @articles
  end
end
