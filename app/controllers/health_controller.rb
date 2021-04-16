class HealthController < ApplicationController
  skip_before_action :authorized, only: [:health]
  
  def health
    render json: {api: 'OK'}, status: :ok
  end
end