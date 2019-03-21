module API
  module V1
    class ProductsController < ApplicationController
      def index
        @product = Product.where("status='A'")
        @product = @product.category_scope(@category) if @category
        @product = @product.sort_scope('product_name ASC') unless @sort
        @product = @product.sort_scope(@sort) if @sort
        @product = @product.term_scope(@term) if @term
        @product = @product.page_scope(@page).includes(
          :category, :like_products
        )
        respond_to do |format|
          format.json { render json: @product }
        end
      end
    end
  end
end
