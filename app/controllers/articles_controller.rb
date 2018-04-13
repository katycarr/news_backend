class ArticlesController < ApplicationController

  def index
    # Clean.new.clear_old
    # FeedManager.new.query_all(loggedin_user.topics)
    @articles = Funnel.new.select(loggedin_user)
    if params[:start]
      start = params[:start].to_i
    else
      start = 0
    end
    @articles = @articles[(start..start+19)]
    render json: @articles
  end

end
