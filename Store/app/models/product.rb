class Product < ApplicationRecord
  # relations
  belongs_to :category
  has_many :order_details
  has_many :car_shop
  has_many :orders, through: :order_details
  has_many :like_products
  has_one_attached :image

  # validations
  validates :sku, :product_name, presence: true
  validates :sku, uniqueness: true
  def self.search(term, page, sort, category)
    if term && category && !sort
      where('product_name LIKE ? AND category_id = ?', "%#{term}%", category).order('product_name ASC').paginate(page: page, per_page: 8)
    elsif term && category && sort
      where('product_name LIKE ? AND category_id = ?', "%#{term}%", category).order(sort).paginate(page: page, per_page: 8)
    elsif !term && !category && sort
      order(sort).paginate(page: page, per_page: 8)
    elsif term && !category && !sort
      where('product_name LIKE ?', "%#{term}%").order('product_name ASC').paginate(page: page, per_page: 8)
    elsif !term && category && sort
      where('category_id = ?', category).order(sort).paginate(page: page, per_page: 8)
    elsif !term && category && !sort
      where('category_id = ?', category).order('product_name ASC').paginate(page: page, per_page: 8)
    elsif term && !category && sort
      where('product_name LIKE ?', "%#{term}%").order(sort).paginate(page: page, per_page: 8)
    else
      order('product_name ASC').paginate(page: page, per_page: 8)
    end
  end
end
