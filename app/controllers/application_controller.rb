class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :display_sidebar?
  before_filter :get_order

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def display_sidebar?
    @display_sidebar = can? :make, Order
  end

  def get_order
    if current_user then
      last_order = current_user.orders.last
      @users_order = last_order if last_order && last_order.status != :closed
    end
  end
end
