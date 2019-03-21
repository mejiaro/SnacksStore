require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @product = products(:one)
    @cat = categories(:one)
    @sort = { sort: 'product_name ASC' }
    @category = { category: @cat.id }
    @term = { term: 'chocolate' }
    @update = {
      sku: 123_455_668,
      product_name: 'Apple',
      price: 1.5,
      quantity: 1,
      category_id: @cat.id,
      status: 'A'
    }
  end

  test 'products index should be success' do
    get products_path
    assert_response :success
  end

  test 'products sort by name should be success' do
    get products_path(@sort)
    assert_response :success
  end

  test 'products search should be success' do
    get products_path(@term)
    assert_response :success
  end

  test 'products should show product' do
    get products_url(@product)
    assert_response :success
  end

  test 'product should get edit' do
    sign_in users(:one)
    get edit_product_url(@product)
    assert_response :success
  end

  test 'products should get new' do
    sign_in users(:one)
    get new_product_url
    assert_response :success
  end

  test 'should create a product' do
    sign_in users(:one)
    assert_difference('Product.count') do
      post products_url, params: { product: @update }
    end

    assert_redirected_to products_path
  end

  test 'products should destroy product' do
    sign_in users(:one)
    delete product_url(@product)
    @product.reload
    assert_equal 'D', @product.status
    assert_redirected_to products_path
  end

  test 'products should redirect when not admin delete product' do
    sign_in users(:two)
    delete product_url(@product)
    assert_redirected_to root_path
  end

  test 'products should redirect when not admin create product' do
    sign_in users(:two)
    assert_no_difference('Product.count') do
      post products_url, params: { product: @update }
    end

    assert_redirected_to root_path
  end
end
