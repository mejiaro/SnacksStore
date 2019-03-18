require 'test_helper'

class CarShopsControllerTest < ActionDispatch::IntegrationTest
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
    get car_shops_path
    assert_response :success
  end

  test 'shopping should create product' do
    sign_in users(:two)
    assert_difference('CarShop.count') do
      post car_shops_path, params: { car_shop: @update }
    end

    assert_redirected_to car_shops_path
  end

  test 'should destroy line item of shopping cart' do
    sign_in users(:two)
    assert_difference('CarShop.count', -1) do
      delete car_shop_path(id: @product.id)
    end

    assert_redirected_to car_shops_path
  end
end
