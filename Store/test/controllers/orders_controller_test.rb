require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test 'should create an order' do
    sign_in users(:two)
    assert_difference('Order.count') do
      post orders_path
    end
    assert_redirected_to products_path
  end

  test 'should not create an order if user is not-logged in' do
    assert_no_difference('Order.count') do
      post orders_path
    end
    assert_redirected_to shopping_carts_path
  end
end
