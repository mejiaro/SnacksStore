class CarShopsController < ApplicationController
  before_action :user_id
  def index
    @total = 0
    if user_signed_in?
      if !current_user.admin?
        seed_cart
        @product = CarShop.all.where(user_id: current_user.id)
      else
        redirect_to(products_path) && return
      end
    else
      @product = CarShop.all.where(user_id: session[:current_user_id])
    end
    @product.each { |val| @total += (val.price * val.quantity) } if @product
  end

  def new
    @car_shop = CarShop.new
  end

  def destroy
    @car_delete = CarShop.find_by(user_id: @user_id, product_id: params[:id])
    if @car_delete.destroy
      update_quantity(@car_delete.quantity, params[:id], false)
      success(car_shops_path, 'Product deleted successfully.')
    else
      error(car_shops_path, 'Product was not deleted.')
    end
  end

  def create
    prd = params[:car_shop][:product_id]
    @cart_list = cart_list(@user_id, prd, params[:car_shop][:quantity])
    if @car_list.save
      update_quantity(params[:car_shop][:quantity], prd, true)
      if prd.quantity <= 3 && !prd.like_products.empty?
        SendNotificationsJob.perform_later(prd)
      end
      success(car_shops_path, 'Product added successfully.')
    else
      error(car_shops_path, 'Product was not added.')
    end
  end

  private

  def car_params
    params.require(:car_shop).permit(:product_id, :quantity, :price).merge(
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
end
