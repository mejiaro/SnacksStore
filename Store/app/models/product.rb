class Product < ApplicationRecord
  # relations
  belongs_to :category
  has_many :order_details
  has_many :log
  has_many :car_shop
  has_many :orders, through: :order_details
  has_many :like_products
  has_one_attached :image

  # validations
  validates :sku, :product_name, presence: true
  validates :sku, uniqueness: true
  validates :quantity, numericality: {
    greater_than_or_equal_to: 0
  }, on: :create

  # scopes
  scope :sort_scope, ->(sort_val) { order(sort_val) }
  scope :term_scope, lambda { |term_val|
                       where('product_name LIKE ?', "%#{term_val}%")
                     }
  scope :category_scope, ->(category_val) { where category_id: category_val }
  scope :page_scope, ->(page_val) { paginate(page: page_val, per_page: 8) }

  def category_name
    category.name
  end

  def image_attach?
    image.attached?
  end

  def big_image
    image.variant(resize: '200x200')
  end

  def medium_image
    image.variant(resize: '100x100')
  end

  def like_size
    like_products.size
  end

  def like_user(prod, id)
    prod.like_products.where(user_id: id)
  end

  def self.price_log(product, old_price, id)
    @log = Log.new(user_id: id,
                   description: 'The price of the product has change',
                   product_id: product.id, old_price: old_price,
                   new_price: product.price)
    @log.save
  end
end
