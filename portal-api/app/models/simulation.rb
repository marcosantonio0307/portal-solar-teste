# frozen_string_literal: true

class Simulation < ApplicationRecord
  belongs_to :customer

  validates :electricity_bill, presence: true

  scope :today, -> { where('created_at >= ?', Time.zone.now.beginning_of_day) }
end
