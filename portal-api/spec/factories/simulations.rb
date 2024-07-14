# frozen_string_literal: true

FactoryBot.define do
  factory :simulation do
    electricity_bill { 200.0 }
    power { 2.5 }
    customer
  end
end
