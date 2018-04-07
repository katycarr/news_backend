class UsersController < ApplicationController
  # skip_before_action :authorized, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      token = issue_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
