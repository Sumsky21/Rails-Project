json.extract! address, :id, :recipient, :district, :details, :postal_code, :phone_number, :user_id, :created_at, :updated_at
json.url address_url(address, format: :json)
