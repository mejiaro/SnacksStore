require 'securerandom'
class ProductsController < ApplicationController
  before_action :set_cache_headers
  before_action :product, :category
  helper_method :product, :category
  def index; end

  def show
    @car_shop = CarShop.new
  end

  def new; end

  def create
    if @product.save
      redirect_to(products_path, flash: { alert: 'Product created successfully.', alert_type: 'success' }) && return
    else
      redirect_to( new_product_url, flash: { alert: 'Product was not created.', alert_type: 'danger' }) && return
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
      redirect_to(products_path, flash: { alert: 'Product was not deleted.', alert_type: 'danger' }) && return
    end
  end

  private

  def product
    @product ||=
      if action_name == 'index'
        Product.with_attached_image.where("status='A'").search(params[:term], params[:page], params[:sort], params[:category]).includes(:category, :like_products)
      elsif %w[update edit show destroy].include?(action_name)
          Product.find(params[:id])
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
    params.require(:product).permit(:quantity, :product_name, :price, :category_id, :image)
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
