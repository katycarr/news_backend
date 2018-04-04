class AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      payload = { user_id: @user.id}
      render json: {user: UserSerializer.new(@user), token: issue_token(payload) }
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end
  end
end
