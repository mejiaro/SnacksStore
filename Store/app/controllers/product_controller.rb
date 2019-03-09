class ProductController < ApplicationController
  def index
    @product = Product.where("status='A'").search(params[:term], params[:page], params[:sort])
    get_variable
  end

  def show
    @car_shop = CarShop.new
    @product = Product.find(params[:id_product])
  end

  def category
    @categ = Category.find(params[:category])
    @product = Product.where(category: @categ).search(params[:term], params[:page], params[:sort])
    get_variable
  end

  private

  def get_variable
    @category = Category.all.order('name ASC')
  end
end
