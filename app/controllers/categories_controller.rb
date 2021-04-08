class CategoriesController < ApplicationController
  
  rescue_from Exception do |e|
    render json: {error: e.message}, status: :internal_error
  end

  rescue_from 'ActiveRecord::RecordInvalid' do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end


  # GET /families
  def index 
    @categories = Category.all 
    # byebug
    if !params[:family_id].nil? && params[:family_id].present?
      @categories = CategorySearchService.search(@categories, params[:family_id])
    end
    render json: @categories, status: :ok
  end

  #  GET /families/{id}
  def show
    @category = Category.find(params[:id])
    render json: @category, status: :ok
  end

  def create 
    @category = Category.create!(create_params)
    render json: @category, status: :created
  end

  def update 
    @category = Category.find(params[:id])
    @category.update!(update_params)
    render json: @category, status: :ok
  end

  private

  def create_params
    params.required(:category).permit(:name, :family_id, :category_type)
  end
  
  def update_params
    params.required(:category).permit(:name, :category_type)
  end

  def category_params

  end

end