require 'test_helper'

class OrderRowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_row = order_rows(:one)
  end

  test "should get index" do
    get order_rows_url
    assert_response :success
  end

  test "should get new" do
    get new_order_row_url
    assert_response :success
  end

  test "should create order_row" do
    assert_difference('OrderRow.count') do
      post order_rows_url, params: { order_row: { item_id: @order_row.item_id, order_id: @order_row.order_id, quantity: @order_row.quantity } }
    end

    assert_redirected_to order_row_url(OrderRow.last)
  end

  test "should show order_row" do
    get order_row_url(@order_row)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_row_url(@order_row)
    assert_response :success
  end

  test "should update order_row" do
    patch order_row_url(@order_row), params: { order_row: { item_id: @order_row.item_id, order_id: @order_row.order_id, quantity: @order_row.quantity } }
    assert_redirected_to order_row_url(@order_row)
  end

  test "should destroy order_row" do
    assert_difference('OrderRow.count', -1) do
      delete order_row_url(@order_row)
    end

    assert_redirected_to order_rows_url
  end
end
