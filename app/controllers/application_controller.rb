class ApplicationController < ActionController::API
  include Secured
  before_action :authorized

end
