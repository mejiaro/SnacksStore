class CarShopsController < ApplicationController
  def index
    usr = User.find(current_user.id)
    @product = CarShop.all.where(user: usr)
    @total = 0
    @product.each { |val| @total += (val.price * val.quantity)}
  end

  def new
    @car_shop = CarShop.new
  end

  def destroy
    usr = User.find(current_user.id)
    @car_delete = CarShop.find_by(user: usr, product: params[:product])
    prd = Product.find(params[:product])
    prd.quantity += @car_delete.quantity.to_i
    if @car_delete.destroy
      prd.save
      redirect_to car_shops_path, flash: { alert: 'Product deleted successfully.', alert_type: 'success' }
    else
      redirect_to car_shops_path, flash: { alert: 'Product was not deleted.', alert_type: 'success' }
    end
  end

  def create
    usr = User.find(params[:car_shop][:user])
    prd = Product.find(params[:car_shop][:product])
    @car_list = CarShop.find_by(user: usr, product: prd)
    if @car_list
      @car_list.quantity += params[:car_shop][:quantity].to_i
    else
      @car_list = CarShop.new(user: usr, product: prd, quantity: params[:car_shop][:quantity], price: params[:car_shop][:price])
    end
    if @car_list.save
      prd.quantity -= params[:car_shop][:quantity].to_i
      prd.save
      redirect_to product_index_path, flash: { alert: 'Product added successfully.', alert_type: 'success' }
    else
      redirect_to product_index_path, flash: { alert: 'Product was not added.', alert_type: 'success' }
    end
  end
end
