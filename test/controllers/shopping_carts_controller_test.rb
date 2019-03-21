require 'test_helper'

class ShoppingCartsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @product = products(:one)
    @update = {
      product_id: 298_486_374,
      price: 1.5,
      quantity: 1
    }
  end

  test 'shopping cart index should be success' do
    sign_in users(:two)
    get shopping_carts_path
    assert_response :success
  end

  test 'shopping should create product' do
    sign_in users(:two)
    assert_difference('ShoppingCart.count') do
      post shopping_carts_path, params: { shopping_cart: @update }
    end

    assert_redirected_to shopping_carts_path
  end

  test 'should destroy line item of shopping cart' do
    sign_in users(:two)
    assert_difference('ShoppingCart.count', -1) do
      delete shopping_cart_path(id: @product.id)
    end

    assert_redirected_to shopping_carts_path
  end
end
