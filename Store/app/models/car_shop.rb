class CarShop < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product
end
