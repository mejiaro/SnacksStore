class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @product = CarShop.all.where(user_id: current_user.id)
    @order = Order.new(user: usr, status: 'N')
    @order.save
    @last = Order.last
    Order.seed_detail(@last, @product) if @product
    @last.status = 'P'
    @last.save
    success(products_path, 'Order created successfully.')
  rescue StandardError
    error(products_path, 'Order was not created.')
  end
end
