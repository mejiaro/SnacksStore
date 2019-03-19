require 'securerandom'
class ProductsController < ApplicationController
  before_action :set_cache_headers
  before_action :product, :category
  helper_method :product, :category
  before_action :admin_only, only: %i[new create edit update destroy]
  before_action :values, only: :index
  def index
    @product = @product.category_scope(@category) if @category
    @product = @product.sort_scope(@sort) if @sort
    @product = @product.term_scope(@term) if @term
    @product = @product.page_scope(@page).includes(
      :category, :like_products
    )
  end

  def show
    @car_shop = CarShop.new
  end

  def new; end

  def create
    if @product.save
      redirect_to(products_path,
                  flash: { alert: 'Product created successfully.',
                           alert_type: 'success' }) && return
    else
      redirect_to(new_product_url,
                  flash: { alert: 'Product was not created.',
                           alert_type: 'danger' }) && return
    end
  end

  def edit; end

  def update
    old_price = @product.price
    @product.assign_attributes(update_params)
    if @product.save
      if old_price != params[:product][:price]
        price_log(@product, old_price, current_user.id)
      end
      redirect_to(products_path) && return
    else
      render 'edit'
    end
  end

  def destroy
    @product.status = 'D'
    if @product.save
      redirect_to(products_path,
                  flash: { alert: 'Product deleted successfully.',
                           alert_type: 'success' }) && return
    else
      redirect_to(products_path,
                  flash: { alert: 'Product was not deleted.',
                           alert_type: 'danger' }) && return
    end
  end

  private

  def product
    @product ||=
      if action_name == 'new'
        Product.new
      elsif %w[update edit show destroy].include?(action_name)
        Product.find(params[:id])
      elsif action_name == 'create'
        Product.new(post_params)
      else
        Product.with_attached_image.where("status='A'")
      end
  end

  def category
    @category = Category.all.order('name ASC')
  end

  def post_params
    params.require(:product).permit(
      :quantity, :product_name, :price, :category_id, :image, :sku, :status
    )
  end

  def update_params
    params.require(:product).permit(
      :quantity, :product_name, :price, :category_id, :image
    )
  end

  def set_cache_headers
    response.headers['Cache-Control'] =
      'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def values
    @category = params[:category]
    @sort = params[:sort]
    @term = params[:term]
    @page = params[:page]
  end
end
