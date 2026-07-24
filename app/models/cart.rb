class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # Adds product to cart or increments quantity if already present
  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  # Calculates total price of all items in cart
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  # Total count of items in cart
  def total_items
    line_items.to_a.sum { |item| item.quantity }
  end
end
