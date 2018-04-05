class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :authorized

  def logged_in?
    !!current_user
  end

  def current_user
    if request.headers["Authorization"]
      jwt_token = request.headers["Authorization"].split(" ")[1]

      begin
        decoded_token = decode_token(jwt_token)
        if user_id = decoded_token[0]["user_id"]
          # then we have a user_id
          @user = User.find_by(id: user_id)
        else

        end
      rescue JWT::DecodeError

      end
    else
      # no auth header
    end
  end

  def issue_token(payload)
    token = JWT.encode(payload, ENV["SECRET_KEY_BASE"], "HS256")
  end

  def decode_token(token)
    JWT.decode(token, ENV["SECRET_KEY_BASE"], true, {algorithm: "HS256"})
  end

  def authorized
    render json: {message: 'Not logged in' } unless logged_in?
  end
end
