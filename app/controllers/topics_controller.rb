class TopicsController < ApplicationController

  def index
    if params["pop"]
      # ordered_topics = Topic.all.sort do |a, b|
      #   b.articles.length <=> a.articles.length
      # end

      # @topics = ordered_topics.first(10)
      @topics = Topic.all.select do |topic|
        topic.articles.length >= 5
      end
    else
      @topics = loggedin_user.topics
    end
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
