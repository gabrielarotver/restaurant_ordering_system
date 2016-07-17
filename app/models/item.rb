class Item < ApplicationRecord

  has_many :order_rows
  has_many :orders, through: :order_rows
end
