module API
  module V1
    class UsersControllerTest < ActionDispatch::IntegrationTest
      test 'login should be success' do
        post api_v1_sessions_path, params: { email: 'cemg_neto@hotmail.com', password: 123_456 }
        resp = response.headers['token']
        get api_v1_users_path, headers: { 'token' => resp }
        assert_response 200
      end
    end
  end
end
