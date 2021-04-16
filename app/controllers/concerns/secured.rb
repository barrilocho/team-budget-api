module Secured
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