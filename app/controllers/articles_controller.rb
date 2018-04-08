class ArticlesController < ApplicationController

  def index
    @articles = Funnel.new.select(loggedin_user)
    sorted_articles = @articles.sort {|a, b| b.published_at <=> a.published_at }
    render json: sorted_articles
  end
end
