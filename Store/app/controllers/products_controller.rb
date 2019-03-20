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
    @shopping_cart = ShoppingCart.new
  end

  def new; end

  def create
    if @product.save
      success(products_path, 'Product created successfully.')
    else
      error(new_product_url, 'Product was not created.')
    end
  end

  def edit; end

  def update
    old_price = @product.price
    @product.assign_attributes(update_params)
    if @product.save
      if old_price != params[:product][:price]
        Product.price_log(@product, old_price, current_user.id)
      end
      success(products_path, 'Product updated successfully.')
    else
      render 'edit'
    end
  end

  def destroy
    @product.status = 'D'
    if @product.save
      success(products_path, 'Product deleted successfully.')
    else
      error(products_path, 'Product was not deleted.')
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
