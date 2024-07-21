# frozen_string_literal: true

json.simulation do
  json.extract! simulation, :id, :customer_id, :electricity_bill, :created_at, :updated_at
  json.power simulation.power.truncate(2)
  json.self_link Rails.application.routes.url_helpers.api_v1_simulation_path(simulation)
  json.download_link Rails.application.routes.url_helpers.download_api_v1_simulation_path(simulation)
  json.chosen_generators simulation.chosen_generators, :id, :uuid, :name, :price, :panels, :power, :image_url
end
