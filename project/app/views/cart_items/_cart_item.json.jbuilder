json.extract! cart_item, :id, :item_id, :user_id, :num, :created_at, :updated_at
json.url cart_item_url(cart_item, format: :json)
