module API
  module V1
    class ProductsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @product = products(:one)
        @sort = { sort: 'product_name ASC' }
        @category = { category: 980_190_962 }
        @term = { term: 'chocolate' }
        @paginate = {page: 2}
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

      test 'products should paginate' do
        get products_path(@paginate)
        assert_response :success
      end
    end
  end
end
