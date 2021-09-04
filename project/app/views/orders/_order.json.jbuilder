json.extract! order, :id, :item_id, :user_id, :address_id, :num, :remark, :EMS_code, :state, :created_at, :updated_at
json.url order_url(order, format: :json)
