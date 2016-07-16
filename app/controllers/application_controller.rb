class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_customer
    #if we find anything, we take the first one, if we don't find anything it'll be nil
    Customer.where(id: session[:customer_id]).first
  end

  helper_method :current_customer
end
