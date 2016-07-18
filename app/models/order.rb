class Order < ApplicationRecord
  belongs_to :customer

  has_many :order_rows, dependent: :destroy
  has_many :items, through: :order_rows

  validates :customer, presence: true

  def to_s
    "Order: #{@order.id}"
  end

  def total_cost
    the_cost = 0
    order_rows.each do |item|
      the_cost += item.item.price * item.quantity
    end
    the_cost
  end

end
