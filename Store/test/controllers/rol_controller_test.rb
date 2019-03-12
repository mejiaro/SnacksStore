require 'test_helper'

class RolControllerTest < ActionDispatch::IntegrationTest
  test "should get rol_name:string" do
    get rol_rol_name:string_url
    assert_response :success
  end

end
