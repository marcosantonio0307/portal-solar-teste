# frozen_string_literal: true

json.simulations do
  json.array! @simulations do |simulation|
    json.extract! simulation, 'id', 'customer_id', 'electricity_bill', 'power', 'created_at', 'updated_at'
    json.self_link Rails.application.routes.url_helpers.api_v1_internal_simulation_path(simulation)
  end
end

json.meta do
  json.current_page @simulations.current_page
  json.total_pages @simulations.total_pages
end
