# frozen_string_literal: true

require 'swagger_helper'

describe 'Internal Simulations API' do
  path '/api/v1/internal/simulations' do
    get 'Retrieves simulations' do
      tags 'Internal Simulations'
      produces 'application/json'
      security [internal_key: []]

      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false
      parameter name: 'Api-Internal-Key', in: :header, type: :string

      let(:internal_key) { ENV['API_INTERNAL_KEY'] }
      let('Api-Internal-Key') { internal_key }

      response '200', 'simulations found' do
        schema(
          type: :object,
          properties: {
            simulations: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  customer_id: { type: :integer },
                  electricity_bill: { type: :number },
                  power: { type: :number },
                  created_at: { type: :string },
                  updated_at: { type: :string },
                  self_link: { type: :string }
                }
              }
            }
          }
        )

        let(:simulations) { create_list(:simulation, 10) }
        let(:page) { 1 }
        run_test!
      end

      response '401', 'unauthorized' do
        let('Api-Internal-Key') { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/internal/simulations/{id}' do
    get 'Retrieves a simulation' do
      tags 'Internal Simulations'
      produces 'application/json'
      security [internal_key: []]

      parameter name: :id, in: :path, type: :integer
      parameter name: 'Api-Internal-Key', in: :header, type: :string

      let(:internal_key) { ENV['API_INTERNAL_KEY'] }
      let('Api-Internal-Key') { internal_key }
      let(:simulation) { create(:simulation) }
      let(:id) { simulation.id }

      response '200', 'simulation found' do
        schema(
          type: :object,
          properties: {
            id: { type: :integer },
            customer_id: { type: :integer },
            electricity_bill: { type: :number },
            power: { type: :number },
            created_at: { type: :string },
            updated_at: { type: :string }
          }
        )

        run_test!
      end

      response '401', 'unauthorized' do
        let('Api-Internal-Key') { 'invalid' }

        run_test!
      end

      response '404', 'simulation not found' do
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
