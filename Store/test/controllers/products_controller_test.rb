require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'index should be success' do
    get '/products'
    assert_response :success
  end
end
