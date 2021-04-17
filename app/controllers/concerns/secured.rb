module Secured
  # def authenticate_user!
  #   token_regex = /Bearer (\w+)/
  #   headers = request.headers 

  #   if headers['Authorization'].present? && headers['Authorization'].match(token_regex)
  #     token = headers['Authorization'].match(token_regex)[1]
  #     if(Current.user = User.find_by_auth_token(token))   #if user exist resturn and continue if not return unathorize
  #       return
  #     end
  #   end
  #   render json: {error: "Unauthorized"}, status: :unauthorize
  # end

  def secret 
    secret = ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base
  end

  def auth_header
    # { Authorizatioon: 'Bearer <token>'}
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: {'Authorizatioon': 'Bearer <token>''}
      begin
        decode_user = JWT.decode(token, secret, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end
  
  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
      Current.user = @user
      @user
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: {message: 'Unauthorized: Please log in'}, status: :unauthorized unless logged_in?
  end

  def encode_token(payload)
    JWT.encode(payload, secret)
  end
end