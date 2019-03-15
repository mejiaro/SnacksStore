require 'securerandom'
class ProductsController < ApplicationController
  before_action :product, :category
  helper_method :product, :category
  def index; end

  def show
    @car_shop = CarShop.new
  end

  def new; end

  def create
    if @product.save
      redirect_to(products_path)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    old_price = @product.price
    @product.assign_attributes(update_params)
    if @product.save
      if old_price != params[:product][:price]
        @log = Log.new(user_id: current_user.id, description: 'The price of the product has change', product_id: @product.id, old_price: old_price, new_price: @product.price)
        @log.save
      end
      redirect_to(products_path) && return
    else
      render 'edit'
    end
  end

  def destroy
    @product.status = 'D'
    if @product.save
      redirect_to(products_path, flash: { alert: 'Product deleted successfully.', alert_type: 'success' }) && return
    else
      redirect_to(products_path, flash: { alert: 'Product was not deleted.', alert_type: 'success' }) && return
    end
  end

  private

  def product
    @product ||=
      if action_name == 'index'
        Product.with_attached_image.where("status='A'").search(params[:term], params[:page], params[:sort], params[:category]).includes(:category, :like_products)
      elsif %w[update edit show destroy].include?(action_name)
        if user_signed_in?
          Product.find(params[:id])
        else
          redirect_to(new_user_session_url)
        end
      elsif action_name == 'create'
        Product.new(post_params)
      elsif action_name == 'new'
        Product.new
      else
        Product.where("status='A'").search(params[:term], params[:page], params[:sort], params[:category])
      end
  end

  def category
    @category = Category.all.order('name ASC')
  end

  def search_params
    params.fetch(:product_name, {}).permit(:category_id, :term, :page, :sort)
  end

  def post_params
    params.require(:product).permit(:quantity, :product_name, :price, :category_id, :image, :sku, :status)
  end

  def update_params
    params.require(:product).permit(:quantity, :product_name, :price, :category_id)
  end
end
