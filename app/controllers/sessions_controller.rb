class SessionsController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_by_email(params[:email])
    if customer && customer.authenticate(params[:password])
      session[:customer_id] = customer.id
      redirect_to root_url, notice: 'Logged in!'
    else
      render :new
    end
  end

  def destroy
    session[:customer_id] = nil
    redirect_to root_url, notice: 'Logged Out!'
  end
end
