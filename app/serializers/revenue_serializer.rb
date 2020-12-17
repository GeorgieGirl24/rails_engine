class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :revenue
end
