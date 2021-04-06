class FamiliesController < ApplicationController
  def index
    @families = Family.all
    render json: @families, status: :ok
  end

  #GET /family/{id}
  def show
    @family = Family.find(params[:id])
    render json: @family, status: :ok
  end
end