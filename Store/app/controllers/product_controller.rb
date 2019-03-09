class ProductController < ApplicationController
  def index
    @product = Product.where("status='A'").search(params[:term], params[:page], params[:sort], params[:likes])
    get_variable
  end

  def show
    if user_signed_in?
      @car_shop = CarShop.new
      @product = Product.find(params[:id_product])
    else
      redirect_to new_user_session_url
    end
  end

  def category
    @categ = Category.find(params[:category])
    @product = Product.where(category: @categ).search(params[:term], params[:page], params[:sort], params[:likes])
    get_variable
  end

  private

  def get_variable
    @category = Category.all.order('name ASC')
  end
end
