module API
  module V1
    class SessionsControllerTest < ActionDispatch::IntegrationTest
      test 'login should be success' do
        post api_v1_sessions_path, params: { email: 'cemg_neto@hotmail.com', password: 123_456 }
        assert_response 200
      end

      test 'email should not be found' do
        post api_v1_sessions_path, params: { email: 'cemg_net@hotmail.com', password: 123_456 }
        assert_response 404
      end

      test 'authentication should failed' do
        post api_v1_sessions_path, params: { email: 'cemg_neto@hotmail.com', password: 12_356 }
        assert_response 403
      end
    end
  end
end
