module ApplicationHelper


  def add_to_cart_button(item)
    button_to 'Add to Cart', line_items_path(item_id: item) unless !user_signed_in?
  end

  def checkout_button(cart)
    if cart.status != "submitted" && !cart.line_items.empty?
      button_to 'Checkout', checkout_path
    end
  end

  def line_item_inventory_msg(line_item)
    if line_item.item.inventory < 5
      "There are only #{line_item.item.inventory} left in stock."
    end
  end
end
