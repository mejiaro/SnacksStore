class CarShopsController < ApplicationController
  before_action :user_id
  def index
    if user_signed_in?
      if current_user.role.rol_name != 'Admin'
        usr = User.find(current_user.id)
        seed_cart
        @product = CarShop.all.where(user: usr)
        @total = 0
        @product.each { |val| @total += (val.price * val.quantity) }
      end
    else
      usr = session[:current_user_id]
      @product = CarShop.all.where(user_id: usr)
      @total = 0
      @product.each { |val| @total += (val.price * val.quantity) }
    end
  end

  def new
    @car_shop = CarShop.new
  end

  def destroy
    @car_delete = CarShop.find_by(user_id: @user_id, product_id: params[:id])
    prd = Product.find(params[:id])
    prd.quantity += @car_delete.quantity.to_i
    if @car_delete.destroy
      prd.save
      redirect_to(car_shops_path, flash: { alert: 'Product deleted successfully.', alert_type: 'success' }) && return
    else
      redirect_to(car_shops_path, flash: { alert: 'Product was not deleted.', alert_type: 'danger' }) && return
    end
  end

  def create
    prd = Product.find(params[:car_shop][:product_id])
    @car_list = CarShop.find_by(user_id: @user_id, product: prd)
    if @car_list
      @car_list.quantity += params[:car_shop][:quantity].to_i
    else
      @car_list = CarShop.new(car_params)
    end
    if @car_list.save
      prd.quantity -= params[:car_shop][:quantity].to_i
      prd.save
      if prd.quantity <= 3 && !prd.like_products.empty?
        SendNotificationsJob.perform_later(prd)
      end
      redirect_to(car_shops_path, flash: { alert: 'Product added successfully.', alert_type: 'success' }) && return
    else
      redirect_to(car_shops_path, flash: { alert: 'Product was not added.', alert_type: 'danger' }) && return
    end
  end

  private

  def car_params
    params.require(:car_shop).permit(:product_id, :quantity, :price).merge(user_id: @user_id)
  end

  def user_id
    @user_id = if user_signed_in?
                 current_user.id
               else
                 unless session[:current_user_id]
                   session[:current_user_id] = SecureRandom.random_number(999_999)
                 end
                 session[:current_user_id]
               end
  end

  def seed_cart
    usr = session[:current_user_id]
    if usr
      @product_session = CarShop.all.where(user_id: usr)
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
