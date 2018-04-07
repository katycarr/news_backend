class AuthController < ApplicationController
  # skip_before_action :authorized, only: [:create]

  def create

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      token = issue_token({user_id: @user.id})
      payload = {user: @user, token: token}
      render json: payload
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end
  end

  def show
    if loggedin_user
      render json: loggedin_user
    else
      render json: {error: "No user found"}
    end
  end
end
