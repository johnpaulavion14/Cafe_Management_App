class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :products
  has_many :shop_details
  has_many :orders
  has_many :product_solds, through: :products
  has_many :total_sold_products

end