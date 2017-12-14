class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  def subtotal
    item.price * quantity
  end
end
