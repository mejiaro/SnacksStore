class ShoppingCartsController < ApplicationController
  before_action :user_id
  before_action :prd, only: %i[create destroy]
  before_action :prod, only: :index
  helper_method :prod
  def index
    @total = 0
    if user_signed_in?
      if !current_user.admin?
        seed_cart
      else
        error(products_path, 'You can\'t buy')
      end
    end
  end

  def new
    @shopping_cart = ShoppingCart.new
  end

  def destroy
    @cart_delete = ShoppingCart.find_by(user_id: @user_id, product_id: params[:id])
    if @cart_delete.destroy
      ShoppingCart.update_quantity(@cart_delete.quantity, @prd, false)
      success(shopping_carts_path, 'Product deleted successfully.')
    else
      error(shopping_carts_path, 'Product was not deleted.')
    end
  end

  def create
    @cart_list = ShoppingCart.cart_list(@user_id, @prd.id,
                                        params[:shopping_cart][:quantity])
    @cart_list ||= ShoppingCart.new(car_params)
    if @cart_list.save
      ShoppingCart.update_quantity(params[:shopping_cart][:quantity], @prd, true)
      success(shopping_carts_path, 'Product added successfully.')
    else
      error(shopping_carts_path, 'Product was not added.')
    end
  end

  private

  def car_params
    params.require(:shopping_cart).permit(:product_id, :quantity, :price).merge(
      user_id: @user_id
    )
  end

  def user_id
    @user_id = if user_signed_in?
                 current_user.id
               else
                 unless session[:current_user_id]
                   session[:current_user_id] =
                     SecureRandom.random_number(999_999)
                 end
                 session[:current_user_id]
               end
  end

  def seed_cart
    if session[:current_user_id]
      @product_session = CarShop.all.where(user_id: session[:current_user_id])
      if @product_session
        @product_session.each do |item|
          item.user_id = current_user.id
          item.save
        end
      end
      session[:current_user_id] == ''
    end
  end

  def prd
    @prd = if action_name == 'create'
             Product.find(params[:shopping_cart][:product_id])
           else
             Product.find(params[:id])
           end
  end

  def prod
    @prod=
      if user_signed_in?
        ShoppingCart.all.where(user_id: current_user.id).includes(:product) unless current_user.admin?
      else
        ShoppingCart.all.where(user_id: session[:current_user_id]).includes(product: :category)
      end
  end
end
