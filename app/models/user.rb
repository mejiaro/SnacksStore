class User < ApplicationRecord
  enum role: %i[user admin]
  after_initialize :set_default_role

  def set_default_role
    self.role ||= :user if new_record?
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :shopping_cart
  has_many :log
  has_many :order
  has_many :comments, as: :commentable

  def rating
    comments.where("status='A' AND rating > 0").average(:rating)
  end
end
