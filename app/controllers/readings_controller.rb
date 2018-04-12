class ReadingsController < ApplicationController

  def create
    @reading = Reading.new(user_id: loggedin_user.id, article_id:params["articleId"])
    if @reading.save
      render json: @reading
    else
      render json: {errors: @reading.errors.full_messages}
    end
  end

  def index
    @readings = loggedin_user.readings
    render json: @readings
  end

  def update
  end
end
