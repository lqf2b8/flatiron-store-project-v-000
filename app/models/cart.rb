class Cart < ActiveRecord::Base
  belongs_to :user

  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.line_items.reduce(0){|total, line_item| total += line_item.subtotal}
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id)

      #Find line_item from line_item list where cart_id matches current cart and modify quantity
      #If cart doesn't include item, build new line_item with cart_id and item_id, otherwise, add 1 to line_item quantity
    if line_item
      line_item.quantity += 1
      line_item.save
    else
      line_item = self.line_items.build(item_id: item_id)
    end

    #return line item
    line_item
  end
end
