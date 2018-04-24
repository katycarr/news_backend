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
    elsif params["article_id"]
      @topics = Article.find(params["article_id"]).topics
    else
      @topics = loggedin_user.topics
    end
    render json: @topics
  end

  def create
    @topic = Topic.find_or_create_by(name: params["topic"]["label"], url:params["topic"]["uri"])
    loggedin_user.topics << @topic
    @articles = paginate(params)
    render json: {topic: @topic, articles: @articles}
  end


  def destroy
    @topic = Topic.find(params[:id])
    loggedin_user.topics.delete(@topic) if @topic
    @articles = paginate(params)
    render json: @articles
  end

  def search
    topic_options = Dbpedia.new.search(params[:q])
    render json: topic_options["results"]
  end


end
