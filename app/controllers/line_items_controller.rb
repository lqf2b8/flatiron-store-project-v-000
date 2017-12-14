class LineItemsController < ApplicationController

  def create

    #find current cart if already set
    cart ||= current_user.current_cart

    #if not found, or if current_cart is already checked out, create new cart
    if cart.nil? || cart.status == 'submitted'
      cart = current_user.carts.create
    end

    #if user current_cart_id not set yet, set to cart that was just created
    if current_user.current_cart_id.nil?
      current_user.current_cart_id = cart.id
      current_user.save
    end

    cart.add_item(params[:item_id])

    if cart.save
      redirect_to cart_path(cart)
    end
  end

end
