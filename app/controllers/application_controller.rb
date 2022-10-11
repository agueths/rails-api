class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials[:jwt_secret_key])
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ').last
      begin
        JWT.decode(token, Rails.application.credentials[:jwt_secret_key], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user?
    decoded_token = decode_token
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def authorization_required
    render json: { message: I18n.t('need_login') }, status: :unauthorized unless authorized_user?
  end
end
