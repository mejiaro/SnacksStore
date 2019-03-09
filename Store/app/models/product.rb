class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details
  has_many :car_shop
  has_many :orders, through: :order_details
  def self.search(term, page, sort)
    if term && !sort
      where('product_name LIKE ?', "%#{term}%").order('product_name ASC').paginate(page: page, per_page: 10)
    elsif term && sort
      where('product_name LIKE ?', "%#{term}%").order(sort).paginate(page: page, per_page: 10)
    elsif !term && sort
      order(sort).paginate(page: page, per_page: 10)
    else
      order('product_name ASC').paginate(page: page, per_page: 10)
    end
  end
end
