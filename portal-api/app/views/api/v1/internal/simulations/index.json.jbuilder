# frozen_string_literal: true

json.simulations do
  json.array! @simulations do |simulation|
    json.extract! simulation, 'id', 'customer_id', 'electricity_bill', 'power', 'created_at', 'updated_at'
  end
end

json.meta do
  json.current_page @simulations.current_page
  json.total_pages @simulations.total_pages
end
