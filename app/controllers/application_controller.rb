class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_shopping_cart

  private
  def set_shopping_cart
    if cookies[:shopping_cart_id].blank?
      #no hay cookie asignada a carrito
      @shopping_cart = ShoppingCart.create!(ip: request.remote_ip)
      cookies[:shopping_cart_id] = @shopping_cart.id
    else
      #ya hay cookie asignadas
      @shopping_cart = ShoppingCart.find(cookies[:shopping_cart_id])
    end
    #excepcion para erro al ver un carrito sin id encontrada
    rescue  ActiveRecord::RecordNotFound => e
      @shopping_cart = ShoppingCart.create!(ip: request.remote_ip)
      cookies[:shopping_cart_id] = @shopping_cart.id
  end
end
