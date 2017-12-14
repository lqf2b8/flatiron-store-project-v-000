class CartsController < ApplicationController

  def show
    @cart = Cart.find_by(id: params[:id])
  end

  def checkout

    # closes out current cart
    cart = current_user.current_cart
    cart.status = 'submitted'

    # subtracts quantity from inventory
    cart.line_items.each do |line_item|
      item = Item.find_by(id: line_item.item_id)
      item.inventory -= line_item.quantity
      item.save
    end

    # sets current_cart to nil on checkout
    current_user.current_cart = nil
    cart.save

    redirect_to cart_path(cart)
  end


end
