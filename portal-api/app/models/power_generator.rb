# frozen_string_literal: true

class PowerGenerator < ApplicationRecord
  validates :uuid, :name, :price, :panels, :power, :image_url, presence: true
  validates :uuid, uniqueness: true
end
