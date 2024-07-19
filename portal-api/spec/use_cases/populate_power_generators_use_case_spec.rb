# frozen_string_literal: true

require 'rails_helper'

describe PopulatePowerGeneratorsUseCase do
  describe '.call' do
    let(:gateway) { PortalSolarGateway }
    let(:response) do
      double(
        'response',
        status: 200,
        body: {
          'items' => [
            {
              'id' => 'abc123',
              'name' => 'generator',
              'price' => 100,
              'panels' => 10,
              'power' => 100.0,
              'image' => 'image.jpg'
            }
          ]
        }.to_json
      )
    end

    before do
      allow(gateway).to receive(:get_generators).and_return(response)
    end

    it 'creates power generators' do
      expect { described_class.call(total_pages: 1, page_size: 1) }.to change { PowerGenerator.count }.by(1)
    end

    context 'when gateway response has generators with the same id' do
      let(:response) do
        double(
          'response',
          status: 200,
          body: {
            'items' => [
              {
                'id' => 'abc123',
                'name' => 'generator',
                'price' => 100,
                'panels' => 10,
                'power' => 100.0,
                'image' => 'image.jpg'
              },
              {
                'id' => 'abc123',
                'name' => 'generator',
                'price' => 100,
                'panels' => 10,
                'power' => 100.0,
                'image' => 'image.jpg'
              }
            ]
          }.to_json
        )
      end

      it 'creates only one power generator' do
        expect { described_class.call(total_pages: 1, page_size: 1) }.to change { PowerGenerator.count }.by(1)
      end
    end

    context 'when gateway response has an error' do
      let(:response) do
        double('response', status: 500)
      end

      it 'does not create power generators' do
        expect { described_class.call(total_pages: 1, page_size: 1) }.not_to(change { PowerGenerator.count })
      end
    end

    context 'when generator id has already been taken' do
      before do
        create(:power_generator, uuid: 'abc123')
      end

      it 'does not create power generators' do
        expect { described_class.call(total_pages: 1, page_size: 1) }.not_to(change { PowerGenerator.count })
      end
    end
  end
end
