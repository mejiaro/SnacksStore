class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @product = ShoppingCart.all.where(user_id: current_user.id)
    @order = Order.new(user_id: current_user.id, status: 'N')
    @order.save
    @last = Order.last
    Order.seed_detail(@product,@last,current_user.id) if @product
    @last.status = 'P'
    @last.save
    success(products_path, 'Order created successfully.')
  rescue StandardError
    error(products_path, 'Order was not created.')
  end
end
