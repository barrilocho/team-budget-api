
class AuthController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # LOGGING IN
  def login 
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}, status: :ok
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def auto_login 
    render json: @user
  end
end
