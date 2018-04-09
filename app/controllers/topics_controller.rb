class TopicsController < ApplicationController

  def index
    if params["pop"]
      @topics = Topic.find_by_sql(["
        SELECT topics.*, COUNT(article_topics) AS article_count
        FROM topics
          INNER JOIN article_topics ON article_topics.topic_id = topics.id
        GROUP BY topics.id
        ORDER BY article_count DESC
        LIMIT 10
        "])
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
