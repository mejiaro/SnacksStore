class CarShop < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product

  validates :quantity, numericality: { greater_than_or_equal_to: 1}, on: :create
end
