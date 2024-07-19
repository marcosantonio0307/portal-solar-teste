# frozen_string_literal: true

class PopulatePowerGeneratorsUseCase
  def self.call(total_pages:, page_size:, power_generators_gateway: PortalSolarGateway)
    new(
      total_pages: total_pages,
      page_size: page_size,
      power_generators_gateway: power_generators_gateway
    ).call
  end

  def initialize(total_pages:, page_size:, power_generators_gateway:)
    @power_generators_gateway = power_generators_gateway
    @total_pages = total_pages
    @page_size = page_size
  end

  def call
    (1..@total_pages).each do |page|
      Rails.logger.info("***** Creating generators from API page #{page}...")

      response = @power_generators_gateway.get_generators(page: page, page_size: @page_size)

      generators = filter_uniq_generators(response)

      generators.each do |generator|
        power_generator = PowerGenerator.create(
          uuid: generator['id'],
          name: generator['name'],
          price: generator['price'].to_i,
          panels: generator['panels'].to_i,
          power: generator['power'].to_f,
          image_url: generator['image']
        )

        if power_generator.errors.any?
          Rails.logger.info("***** Error to create generator: #{power_generator.errors.full_messages.join(', ')}")
        end
      end

      Rails.logger.info("***** Finish create generators from API page #{page}")
    end
  end

  private

  def filter_uniq_generators(response)
    return [] if response.status != 200

    generators = JSON.parse(response.body)['items']

    uniq_generators = []

    generators.each do |generator|
      uniq_generators << generator unless uniq_generators.any? { |g| g['id'] == generator['id'] }
    end

    uniq_generators
  end
end
