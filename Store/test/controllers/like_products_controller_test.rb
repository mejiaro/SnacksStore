require 'test_helper'

class LikeProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @product = products(:one)
    @product = products(:two)
    @user = users(:two)
  end

  test 'should create a like' do
    sign_in users(:two)
    assert_difference('LikeProduct.count') do
      post like_products_path, params: { id: @product.id }
    end
  end

  test 'should destroy like' do
    sign_in users(:two)
    assert_difference('LikeProduct.count', -1) do
      delete like_product_path(@product)
    end
  end
end
