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
        Product.where("status='A'").search(params[:term], params[:page], params[:sort], params[:likes])
      elsif action_name == 'show'
        if user_signed_in?
          Product.find(params[:id_product])
        else
          redirect_to(new_user_session_url)
        end
      else
        Product.where(category_id: params[:category]).search(params[:term], params[:page], params[:sort], params[:likes])
      end
  end

  def category
    @category = Category.all.order('name ASC')
  end
end
