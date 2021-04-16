class UsersController < ApplicationController
  # skip_before_action :authorized, only: [:create]
  before_action :authorized, only: []

  # REGISTER
  def create 
    @user = User.create(user_params)
    # puts user_params
    # puts @user.errors
    # if @user.errors.present?
    #   puts @user.errors.present?
    #   puts @user.errors.full_messages
    # end
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token} 
    else
      render json: {error: "Invalid username or password"}
    end
  end

  private
  def user_params
    params.permit(:username, :password, :email, :first_name, :last_name)
  end
end