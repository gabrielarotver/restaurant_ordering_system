class Order < ApplicationRecord
  belongs_to :customer

  validates :customer, presence: true

  def to_s
    "Order: #{@order.id}"
  end
end
