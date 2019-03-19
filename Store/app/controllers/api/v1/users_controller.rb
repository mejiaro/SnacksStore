module API
  module V1
    class UsersController < ApplicationController
      def index
        rkey = '82a4ca11-464c-49ae-ab3c-9c9f99909b0d'
        data = request.headers['token']
        begin
          decoded = JWT.decode data, rkey, true, algorithm: 'HS256'
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
