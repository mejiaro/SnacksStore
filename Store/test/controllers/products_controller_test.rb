require 'test_helper'
require 'minitest/mock'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @sort = { sort: 'product_name ASC' }
    @category = { category: 980_190_962 }
    @term = { term: 'chocolate' }
    @update = {
      sku: 123_455_668,
      product_name: 'Apple',
      price: 1.5,
      quantity: 1,
      category_id: 980_190_962,
      status: 'A'
    }
  end

  test 'index should be success' do
    get products_path
    assert_response :success
  end

  test 'sort by name should be success' do
    get products_path(@sort)
    assert_response :success
  end

  test 'search should be success' do
    get products_path(@term)
    assert_response :success
  end

  test 'should show product' do
    get products_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url, params: { product: @update }
    end

    assert_redirected_to products_path
  end

  test 'should destroy product' do
    delete product_url(@product)
    @product.reload
    assert_equal 'D', @product.status
    assert_redirected_to products_path
  end
end
