class UsersController < ApplicationController
  # skip_before_action :authorized, only: [:create]
  before_action :authorized, only: []

  # REGISTER NEW FAMILY
  def createFamilyUser
    @family = Family.new(family_params)
    @family.code = 
    @family.members = 1
    @family.balance = 0
    @family.save
    @user = User.new(user_params)
    @user.family_id = @family.id
    @user.save
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token} 
    else
      render json: {erros: @user.errors.full_messages}
    end
  end

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
    params.require(:user).permit(:username, :password, :email, :first_name, :last_name)
  end

  def family_params
    params.require(:family).permit(:alias_name)
  end
end