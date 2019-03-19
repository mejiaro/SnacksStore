module API
  module V1
    class ProductsController < ApplicationController
      def index
        @product = Product.where("status='A'").search(params[:term], params[:page], params[:sort], params[:category])
        respond_to do |format|
          format.json { render json: @product }
        end
      end
    end
  end
end
