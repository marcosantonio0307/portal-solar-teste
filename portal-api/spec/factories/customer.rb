# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { 'John' }
    email { 'john@test.test' }
    password { '123456' }
  end
end
