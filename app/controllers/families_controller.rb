class FamiliesController < ApplicationController

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
    render json: @family, status: :ok
  end

  #POST /families
  def create
    @family = Family.create!(create_params)
    render json: @family, status: :created
  end

  #PUT /families/{id}
  def update
    @family = Family.find(params[:id])
    @family.update!(update_params)
    render json: @family, status: :ok
  end

  private

  def create_params
    params.required(:family).permit(:alias_name, :balance, :code, :members)
  end

  def update_params
    params.required(:family).permit(:alias_name)
  end
end