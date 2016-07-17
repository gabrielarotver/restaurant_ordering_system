class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_rows
  has_many :items, through: :order_rows

  validates :customer, presence: true

  def to_s
    "Order: #{@order.id}"
  end
end
