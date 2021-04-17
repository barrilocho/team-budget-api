class CategoriesController < ApplicationController
  # before_action :authorized, only: [:create, :update, :index, :show]

  rescue_from Exception do |e|
    render json: {error: e.message}, status: :internal_error
  end

  rescue_from 'ActiveRecord::RecordInvalid' do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end


  # GET /families
  def index 
    @categories = Category.all 
    if !params[:family_id].nil? && params[:family_id].present?
      @categories = CategorySearchService.search(@categories, params[:family_id])
    end
    render json: @categories.includes(:family), status: :ok
  end

  #  GET /families/{id}
  def show
    @category = Category.find(params[:id])
    if(Current.user && (Current.user.family_id == @category.family_id))
      render json: @category, status: :ok
    else
      render json: {error: "Not Found"}, status: :not_found
    end
  end

  def create 
    new_user = create_params;
    new_user["family_id"] = Current.user.family_id
    @category = Category.create!(new_user)
    render json: @category, status: :created
  end

  def update 
    @category = Category.find(params[:id])
    if Current.user.family_id == @category.family_id
      @category.update!(update_params)
      render json: @category, status: :ok
    else
      render json: {error: "Not Found"}, status: :not_found
    end
  end

  private

  def create_params
    params.required(:category).permit(:name, :category_type)
  end
  
  def update_params
    params.required(:category).permit(:name, :category_type)
  end

  def category_params

  end

end