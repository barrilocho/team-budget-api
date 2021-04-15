
class FamiliesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :update, :show]

  rescue_from Exception do |e|
    render json: {error: e.message}, status: :internal_error
  end

  rescue_from 'ActiveRecord::RecordInvalid' do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end

  def index
    @families = Family.all
    render json: @families, status: :ok
  end

  #GET /family/{id}
  def show 
    @family = Family.find(params[:id])
    if(Current.user && (Current.user.family_id == @family.id))
      render json: @family, status: :ok
    else
      render json: {error: "Not Found"}, status: :not_found
    end
  end

  #POST /families
  def create

    @family = Family.create!(create_params)
    render json: @family, status: :created
  end

  #PUT /families/{id}
  def update
    if Current.user.family_id == params[:id] 
      @family = Family.find(params[:id])
      @family.update!(update_params)
      render json: @family, status: :ok
    else
      render json: {error: "Unauthorized"}, status: :unauthorize
    end
    
  end

  private

  def create_params
    params.required(:family).permit(:alias_name, :balance, :code, :members)
  end

  def update_params
    params.required(:family).permit(:alias_name)
  end

  def authenticate_user!
    token_regex = /Bearer (\w+)/
    headers = request.headers 

    if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
      token = headers['Authorization'].match(token_regex)[1]
      if(Current.user = User.find_by_auth_token(token))   #if user exist resturn and continue if not return unathorize
        return
      end
    end
    render json: {error: "Unauthorized"}, status: :unauthorize
  end

end