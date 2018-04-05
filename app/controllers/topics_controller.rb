class TopicsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @topics = @user.topics
    render json: @topics
  end
end
