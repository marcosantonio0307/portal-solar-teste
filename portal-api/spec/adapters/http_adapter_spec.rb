# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HttpAdapter do
  let(:url) { 'http://example.com' }
  let(:path) { '/path' }
  let(:payload) { { key: 'value' } }
  let(:headers) { { 'Authorization' => 'Bearer token' } }

  describe '.get' do
    it 'makes a GET request' do
      expect(Faraday).to(
        receive(:new).with(
          url: url,
          headers: described_class::HEADERS.merge(headers)
        ).and_return(double(get: nil))
      )

      described_class.get(url: url, path: path, payload: payload, headers: headers)
    end
  end

  describe '.post' do
    it 'makes a POST request' do
      expect(Faraday).to(
        receive(:new).with(
          url: url,
          headers: described_class::HEADERS.merge(headers)
        ).and_return(double(post: nil))
      )

      described_class.post(url: url, path: path, payload: payload, headers: headers)
    end
  end

  describe '.put' do
    it 'makes a PUT request' do
      expect(Faraday).to(
        receive(:new).with(
          url: url,
          headers: described_class::HEADERS.merge(headers)
        ).and_return(double(put: nil))
      )

      described_class.put(url: url, path: path, payload: payload, headers: headers)
    end
  end

  describe '.delete' do
    it 'makes a DELETE request' do
      expect(Faraday).to(
        receive(:new).with(
          url: url,
          headers: described_class::HEADERS.merge(headers)
        ).and_return(double(delete: nil))
      )

      described_class.delete(url: url, path: path, payload: payload, headers: headers)
    end
  end
end
