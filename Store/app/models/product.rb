class Product < ApplicationRecord
  belongs_to :category
  def self.search(term, page, sort)
    if term && !sort
      where('product_name LIKE ?', "%#{term}%").order("product_name ASC").paginate(page: page, per_page: 9)
    elsif term && sort
      where('product_name LIKE ?', "%#{term}%").order(sort).paginate(page: page, per_page: 9)
    elsif !term && sort
      order(sort).paginate(page: page, per_page: 9)
    else
      order("product_name ASC").paginate(page: page, per_page: 9)
    end
  end
end
