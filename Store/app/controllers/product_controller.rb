class ProductController < ApplicationController
  def index
    @product = Product.where("status='A'").search(params[:term], params[:page]).order(params[:order])
  end
  def all
    @product = Product.where("status='A'").order(params[:order])
  end
  def show
    @product = Product.find(params[:id])
  end
end
