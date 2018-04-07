class TopicsController < ApplicationController

  def index
    @topics = loggedin_user.topics
    render json: @topics
  end

  def create
    @topic = Topic.find_or_create_by(name: params["topic"]["label"], url:params["topic"]["uri"])
    loggedin_user.topics << @topic
    render json: @topic
  end


  def destroy
    @topic = Topic.find(params[:id])
    loggedin_user.topics.delete(@topic) if @topic
    render json: {message: 'Success!'}
  end


end
