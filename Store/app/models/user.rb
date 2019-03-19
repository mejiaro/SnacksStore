class User < ApplicationRecord
  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :car_shop
  has_many :log
  has_many :order
end
