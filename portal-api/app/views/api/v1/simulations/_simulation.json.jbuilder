# frozen_string_literal: true

json.simulation do
  json.extract! @simulation, :id, :customer_id, :electricity_bill, :power, :created_at, :updated_at
end
