# frozen_string_literal: true

class PortalSolarGateway
  HOST = ENV.fetch('PORTAL_SOLAR_HOST')
  KEY = ENV.fetch('PORTAL_SOLAR_KEY')

  class << self
    def find_generators(power:, adapter: HttpAdapter)
      adapter.get(
        url: HOST,
        path: "/geradores?key=#{KEY}&potencia=#{power}",
        headers: {}
      ).body
    rescue Faraday::Error => e
      Rails.logger.error(e)

      nil
    end
  end
end
