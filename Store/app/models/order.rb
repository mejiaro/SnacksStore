class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details

  def self.seed_detail(product, last_order,id)
    product.each do |val|
      @detail = OrderDetail.new(order: last_order,
                                product: val.product,
                                quantity: val.quantity,
                                price: val.price,
                                status: 'P')
      ShoppingCart.where(user_id: id, product: val.product).destroy_all if @detail.save
    end
  end
end
