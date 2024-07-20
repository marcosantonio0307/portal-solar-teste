# frozen_string_literal: true

class ChosenGenerator < ApplicationRecord
  belongs_to :simulation

  validates :uuid, :name, :price, :panels, :power, :image_url, presence: true
end
