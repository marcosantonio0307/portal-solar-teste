# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PortalSolarGateway do
  describe '.get_generators' do
    context 'when the request is successful' do
      let(:response) { double(Faraday::Response) }

      before do
        allow(HttpAdapter).to receive(:get).and_return(response)
      end

      it 'returns the generators' do
        expect(described_class.get_generators(page: 1, page_size: 50)).to eq(response)
      end
    end

    context 'when the request fails' do
      before do
        allow(HttpAdapter).to receive(:get).and_raise(Faraday::Error)
      end

      it 'returns nil' do
        expect(described_class.get_generators(page: 1, page_size: 50)).to be_nil
      end
    end
  end
end
