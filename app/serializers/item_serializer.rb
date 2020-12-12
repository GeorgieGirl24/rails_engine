class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price, :created_at, :updated_at
end
