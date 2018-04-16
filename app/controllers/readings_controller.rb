class ReadingsController < ApplicationController

  def create
    @reading = Reading.new(user_id: loggedin_user.id, article_id:params["articleId"])
    if @reading.save
      render json:  @reading.article
    else
      render json: {errors: @reading.errors.full_messages}
    end
  end

  def index
    @readinglist = loggedin_user.readings.select { |reading| reading.read? == false}
    @archive = loggedin_user.readings.select { |reading| reading.read? == true}
    list_article_ids = @readinglist.map { |reading| reading.article }
    archive_article_ids = @archive.map { |reading| reading.article }
    render json: {reading_list: list_article_ids, archive: archive_article_ids}
  end

  def update
    @article = Article.find(params[:id])
    @reading = Reading.find_by(article_id:params[:id], user_id: loggedin_user.id)
    @reading.update(read?: true)
    if @reading.save
      render json: @article
    else
      render json: {errors: @reading.errors.full_messages}
    end
  end
end
