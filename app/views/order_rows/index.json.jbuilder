json.array!(@order_rows) do |order_row|
  json.extract! order_row, :id, :item_id, :order_id, :quantity
  json.url order_row_url(order_row, format: :json)
end
