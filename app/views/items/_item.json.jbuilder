json.extract! item, :id, :name, :description, :model_number, :quantity, :unit_price, :total_value, :created_at, :updated_at
json.url item_url(item, format: :json)