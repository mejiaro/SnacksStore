class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    usr = User.find(current_user.id)
    @product = CarShop.all.where(user: usr)
    @order = Order.new(user: usr, status: 'N')
    @order.save
    @last = Order.last
    @product.each do |val|
      @detail = OrderDetail.new(order: @last,
                                product: val.product,
                                quantity: val.quantity,
                                price: val.price,
                                status: 'P')
      CarShop.where(user: usr, product: val.product).destroy_all if @detail.save
    end
    @last.status = 'P'
    @last.save
    redirect_to products_path and return
  end
end
