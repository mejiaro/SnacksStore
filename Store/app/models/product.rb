class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :car_shop
  has_many :orders, through: :order_details
  has_many :like_products
  def self.search(term, page, sort, like)
    if term && !sort
      where('product_name LIKE ?', "%#{term}%").order('product_name ASC').paginate(page: page, per_page: 8)
    elsif term && sort
      where('product_name LIKE ?', "%#{term}%").order(sort).paginate(page: page, per_page: 8)
    elsif !term && sort
      order(sort).paginate(page: page, per_page: 8)
    elsif term && like
      where('product_name LIKE ?', "%#{term}%").order(like).paginate(page: page, per_page: 8)
    elsif !term && like
      order(like, 'product_name ASC').paginate(page: page, per_page: 8)
    else
      order('product_name ASC').paginate(page: page, per_page: 8)
    end
  end
end
