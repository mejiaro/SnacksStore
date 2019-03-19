module API
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      def create
        rkey = '82a4ca11-464c-49ae-ab3c-9c9f99909b0d'
        @user = User.where(email: params[:email]).first
        if User.find_by(email: params[:email])
          if @user.valid_password?(params[:password])
            token = JWT.encode(
              { user_id: @user.id, exp: (Time.now + 2.weeks).to_i },
              rkey,
              'HS256'
            )
            render  status: 200,
                    json: { success: true,
                            info: 'Logged in sucessfully.' }
            response.headers['token'] = token

          else
            render  status: 403,
                    json: { success: false,
                            info: 'Login failed.' }
          end
        else
          render  status: 404,
                  json: { success: false,
                          info: 'Email not found.' }
        end
      end
    end
  end
end
