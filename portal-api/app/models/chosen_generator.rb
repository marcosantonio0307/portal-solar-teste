# frozen_string_literal: true

class ChosenGenerator < ApplicationRecord
  belongs_to :simulation

  validates :uuid, :name, :price, :panels, :power, :image_url, presence: true

  def price_in_money
    price / 100.0
  end
end
