class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :display_sidebar?
  before_filter :get_order

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def display_sidebar?
    @display_sidebar = true
  end

  def get_order
    if current_user then
      @order = current_user.has_open_order?
    end
  end
end
