class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authorize #, except: [:show, :index]
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.customer_id = session[:customer_id]
    @order_rows = []
    Item.all.each do |item|
      row = OrderRow.new
      row.item = item
      row.quantity = 0
      row.save
      @order_rows << row
    end
    @order.order_rows = @order_rows
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    puts "\n\n#{params[:quantity]}\n\n"

    @order = current_customer.orders.build()
    @order.order_rows = []

    @order.total = 0 #need to update

    #only create order rows for items with quantity > 0
    params[:quantity].each_with_index do |quantity, counter|
      if quantity.to_i > 0
        @order.order_rows << OrderRow.create(order: @order, item: Item.find(counter+1), quantity: quantity)
      end
    end

    @order.total = @order.total_cost

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit() #might need to add orderItems
    end

    def authorize
      if current_customer.nil?
        redirect_to login_url, alert: "Sign Up or Log In to make a new order!"
      else
        #Customer is logged in and trying to edit other customer's order
        if @order && @order.customer != current_customer
          redirect_to root_path, alert: "Not authorized! Only #{@order.customer} has access to this order."
        end
      end
    end
end
