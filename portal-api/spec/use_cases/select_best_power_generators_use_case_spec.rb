# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SelectBestPowerGeneratorsUseCase do
  describe '.call' do
    subject { described_class.call(simulation: simulation) }

    let(:customer) { create(:customer) }
    let(:simulation) { create(:simulation, customer: customer, power: 20.5) }
    let!(:power_generators) do
      [
        create(:power_generator, power: 10.5, uuid: 'abc123'),
        create(:power_generator, power: 20.5, uuid: 'def456'),
        create(:power_generator, power: 30.5, uuid: 'ghi789'),
        create(:power_generator, power: 40.5, uuid: 'jkl012')
      ]
    end

    it 'creates chosen generators with the best power generators' do
      subject

      chosen_generators = simulation.chosen_generators

      expect(chosen_generators.map(&:power)).to eq([20.5, 30.5, 40.5])
    end
  end
end
