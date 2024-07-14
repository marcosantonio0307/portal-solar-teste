# frozen_string_literal: true

class HttpAdapter
  HEADERS = {
    content_type: 'application/json'
  }.freeze

  class << self
    def get(url:, path: nil, payload: {}, headers: {})
      conn(url, headers).get(path, payload)
    end

    def post(url:, path: nil, payload: {}, headers: {})
      conn(url, headers).post(path, payload)
    end

    def put(url:, path: nil, payload: nil, headers: {})
      conn(url, headers).put(path, payload)
    end

    def delete(url:, path: nil, payload: nil, headers: {})
      conn(url, headers).delete(path, payload)
    end

    def conn(url, headers)
      Faraday.new(url: url, headers: HEADERS.merge(headers))
    end
  end
end
