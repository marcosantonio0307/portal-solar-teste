# frozen_string_literal: true

class CreateSimulationUseCase
  POWER_FACTOR = ENV.fetch('POWER_FACTOR', 94.5).to_f
  SIMULATIONS_LIMIT_PER_DAY = ENV.fetch('SIMULATIONS_LIMIT_PER_DAY', 5).to_i

  def self.call!(customer:, electricity_bill:)
    new(customer: customer, electricity_bill: electricity_bill).call
  end

  def initialize(customer:, electricity_bill:)
    @customer = customer
    @electricity_bill = electricity_bill
  end

  def call
    raise ActiveRecord::RecordInvalid if @electricity_bill.blank? || @customer.blank? || exceeds_limit_per_day?

    Simulation.create!(
      customer: @customer,
      electricity_bill: @electricity_bill,
      power: power
    )
  end

  private

  def exceeds_limit_per_day?
    @customer.simulations.today.count > SIMULATIONS_LIMIT_PER_DAY
  end

  def power
    @electricity_bill.to_f / POWER_FACTOR
  end
end
