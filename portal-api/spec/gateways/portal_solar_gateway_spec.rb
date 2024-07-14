# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PortalSolarGateway do
  describe '.find_generators' do
    context 'when the request is successful' do
      let(:response) { double(body: '{"generators": []}', status: 200) }

      before do
        allow(HttpAdapter).to receive(:get).and_return(response)
      end

      it 'returns the generators' do
        expect(described_class.find_generators(power: 100)).to eq('{"generators": []}')
      end
    end

    context 'when the request fails' do
      before do
        allow(HttpAdapter).to receive(:get).and_raise(Faraday::Error)
      end

      it 'returns nil' do
        expect(described_class.find_generators(power: 100)).to be_nil
      end
    end
  end
end
