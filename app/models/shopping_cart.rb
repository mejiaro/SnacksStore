class ShoppingCart < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }, on: :create

  def self.update_quantity(quantity, prd, type)
    if type
      prd.quantity -= quantity.to_i
    else
      prd.quantity += quantity.to_i
    end
    prd.save
    if prd.quantity.to_i <= 3 && !prd.like_products.empty?
      SendNotificationsJob.perform_later(prd)
    end
  end

  def self.cart_list(user_id, product_id, quantity)
    list = ShoppingCart.find_by(user_id: user_id, product_id: product_id)
    list.quantity += quantity.to_i if list
    list
  end

  def category_name
    product.category.name
  end

  def product_name
    product.product_name
  end

  def prod_sku
    product.sku
  end
end
