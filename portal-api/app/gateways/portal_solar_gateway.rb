# frozen_string_literal: true

class PortalSolarGateway
  HOST = ENV.fetch('PORTAL_SOLAR_HOST')
  KEY = ENV.fetch('PORTAL_SOLAR_KEY')

  class << self
    def get_generators(page: 1, page_size: 5, adapter: HttpAdapter)
      adapter.get(
        url: HOST,
        path: "/geradores?key=#{KEY}&page=#{page}&page_size=#{page_size}",
        headers: {}
      )
    rescue Faraday::Error => e
      Rails.logger.error(e)

      nil
    end
  end
end
