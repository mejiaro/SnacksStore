class ProductController < ApplicationController
  before_action :product, :category
  helper_method :product, :category
  def index; end

  def show
    @car_shop = CarShop.new
  end

  def category; end

  private

  def product
    @product ||=
      if action_name == 'index'
        Product.where("status='A'").search(params[:term], params[:page], params[:sort], params[:category])
      elsif action_name == 'show'
        if user_signed_in?
          Product.find(params[:id])
        else
          redirect_to(new_user_session_url)
        end
      else
        Product.where("status='A'").search(params[:term], params[:page], params[:sort], params[:category])
      end
  end

  def category
    @category = Category.all.order('name ASC')
  end

  def search_params
    params.fetch(:product_name, {}).permit(:category_id, :term, :page, :sort, :likes)
  end
end
