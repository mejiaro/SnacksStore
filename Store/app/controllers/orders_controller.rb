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
      @detail.save
    end
    @last.status = 'P'
    @last
    CarShop.where(user: usr).destroy_all
    redirect_to product_index_path
  end
end
