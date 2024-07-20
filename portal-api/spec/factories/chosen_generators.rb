# frozen_string_literal: true

FactoryBot.define do
  factory :chosen_generator do
    simulation
    uuid { 'abc123' }
    name { 'generator' }
    price { 100 }
    panels { 10 }
    power { 100.0 }
    image_url { 'image.jpg' }
  end
end
