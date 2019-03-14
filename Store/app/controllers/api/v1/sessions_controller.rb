module API
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      RKEY = Rails.application.secrets.secret_key_base.to_s
      def create
        @user = User.where(email: params[:email]).first
        if User.find_by(email: params[:email])
          if @user.valid_password?(params[:password])
            token = JWT.encode(
              { user_id: @user.id, exp: (Time.now + 2.weeks).to_i },
              RKEY,
              'HS256'
            )
            render  status: 200,
                    json: { success: true,
                            info: 'Logged in sucessfully.' }
            response.headers['token'] = token

          else
            render  status: :Unauthorized,
                    json: { success: false,
                            info: 'Login failed.' }
          end
        else
          render  status: 422,
                  json: { success: false,
                          info: 'Login failed.' }
        end
      end

      def index
        data = request.headers['token']
        begin
          decoded = JWT.decode data, RKEY, true, algorithm: 'HS256'
          user_id = decoded[0]['user_id']
          @user = User.find(user_id)
          render json: { user: @user }
        rescue JWT::VerificationError
          render json: { info: 'token expired' }, status: :unathorized
        rescue StandardError
          render json: { info: 'user not found' }, status: :not_found
        end
      end
    end
  end
end
