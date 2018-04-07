class ArticlesController < ApplicationController

  def index
    @articles = Funnel.new.select(loggedin_user)
    render json: @articles
  end
end
