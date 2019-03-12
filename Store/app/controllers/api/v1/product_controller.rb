module API
  module V1
    class ProductController < ApplicationController
      def index
        @product = Product.where("status='A'")
        respond_to do |format|
          format.json { render json: @product }
        end
      end
    end
  end
end
