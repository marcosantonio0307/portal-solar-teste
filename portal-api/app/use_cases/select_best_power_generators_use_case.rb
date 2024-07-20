# frozen_string_literal: true

class SelectBestPowerGeneratorsUseCase
  MAX_CHOICES = 3

  def self.call(simulation:)
    new(simulation: simulation).call
  end

  def initialize(simulation:)
    @simulation = simulation
  end

  def call
    best_power_generators = find_best_power_generators

    best_power_generators.each do |power_generator|
      ChosenGenerator.create(
        simulation: @simulation,
        uuid: power_generator.uuid,
        name: power_generator.name,
        price: power_generator.price,
        panels: power_generator.panels,
        power: power_generator.power,
        image_url: power_generator.image_url
      )
    end
  end

  private

  def find_best_power_generators
    PowerGenerator.reorder(Arel.sql("ABS(power - #{@simulation.power})"))
                  .where('power >= ?', @simulation.power)
                  .limit(MAX_CHOICES)
  end
end
