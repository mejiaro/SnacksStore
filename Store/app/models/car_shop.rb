class CarShop < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }, on: :create

  def update_quantity(quantity, id, type)
    prd = Product.find(id)
    if type
      prd.quantity -= quantity
    else
      prd.quantity += quantity
    end
    prd.save
  end

  def cart_list(user_id, product_id, quantity)
    list = CarShop.find_by(user_id: user_id, product_id: product_id)
    if cart_list
      list.quantity += quantity
    else
      list = CarShop.new(car_params)
    end
    list
  end
end
