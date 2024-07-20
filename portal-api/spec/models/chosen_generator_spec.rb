# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChosenGenerator do
  it { is_expected.to belong_to(:simulation) }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:panels) }
  it { is_expected.to validate_presence_of(:power) }
  it { is_expected.to validate_presence_of(:image_url) }

  describe '#price_in_money' do
    it 'returns the price in money' do
      chosen_generator = ChosenGenerator.new(price: 1000)

      expect(chosen_generator.price_in_money).to eq(10.0)
    end
  end
end
