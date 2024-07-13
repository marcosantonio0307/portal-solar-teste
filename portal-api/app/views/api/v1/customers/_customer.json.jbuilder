# frozen_string_literal: true

json.customer do
  json.extract! @customer, :id, :name, :email, :created_at, :updated_at
end
