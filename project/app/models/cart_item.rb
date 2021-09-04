class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :num, presence: true

  def add_one(item)
    if item
      item.num += 1
    else
      item = cart_items.build(item_id: 1, user_id: current_user.id, num: 1)
    end
    item
  end

  def remove_one(item)
    if item.num > 1
      item.num -= 1
    elsif item.num == 1
      item.destroy
    end
    item
  end

  def total_price(cart_item)
    cart_item.item.price * cart_item.num
  end

  def sum_total(cart_items)
    result = 0
    cart_items.each do |row|
      result += row.item.price * row.num
    end
    result
  end
end
