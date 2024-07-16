# frozen_string_literal: true

require 'swagger_helper'

describe 'Simulations API' do
  simulation_schema = {
    type: :object,
    properties: {
      simulation: {
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

  path '/api/v1/simulations' do
    get 'Retrieves simulations' do
      tags 'Customers'
      produces 'application/json'
      security [auth_token: []]

      parameter name: :id, in: :path, type: :integer
      parameter name: :page, in: :query, type: :integer, required: false
      parameter name: :per_page, in: :query, type: :integer, required: false

      let(:customer) { create(:customer) }
      let(:id) { customer.id }
      let('Authorization') { customer.create_new_auth_token['Authorization'] }

      response '200', 'customer simulations found' do
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
            },
            meta: {
              type: :object,
              properties: {
                current_page: { type: :integer },
                total_pages: { type: :integer }
              }
            }
          }
        )

        run_test!
      end

      response '401', 'unauthorized' do
        let('Authorization') { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/simulations' do
    post 'Creates a simulation' do
      tags 'Simulations'
      consumes 'application/json'
      produces 'application/json'
      security [auth_token: []]

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          electricity_bill: { type: :float }
        },
        required: %w[electricity_bill]
      }

      let(:customer) { create(:customer) }
      let('Authorization') { customer.create_new_auth_token['Authorization'] }

      response '200', 'simulation created' do
        schema simulation_schema

        let(:params) { { electricity_bill: 100 } }

        run_test!
      end

      response '422', 'invalid request' do
        context 'when electricity_bill is missing' do
          let(:params) { {} }

          run_test!
        end
      end
    end
  end

  path '/api/v1/simulations/{id}' do
    get 'Retrieves a simulation' do
      tags 'Simulations'
      produces 'application/json'
      security [auth_token: []]

      parameter name: :id, in: :path, type: :integer

      let(:customer) { create(:customer) }
      let('Authorization') { customer.create_new_auth_token['Authorization'] }
      let(:id) { create(:simulation, customer: customer).id }

      response '200', 'simulation found' do
        schema simulation_schema

        run_test!
      end

      response '404', 'simulation not found' do
        let(:id) { 'invalid' }

        run_test!
      end

      response '401', 'unauthorized' do
        let('Authorization') { 'invalid' }

        run_test!
      end
    end
  end
end
