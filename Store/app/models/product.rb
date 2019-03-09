class Product < ApplicationRecord
  belongs_to :category
  def self.search(term, page)
    if term
      where('product_name LIKE ?', "%#{term}%").paginate(page: page, per_page: 9)
    else
      paginate(page: page, per_page: 9)
    end
  end
end
