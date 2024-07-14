# frozen_string_literal: true

require 'swagger_helper'

describe 'Simulations API' do
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
        schema(type: :object,
               properties: {
                 simulation: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     customer_id: { type: :integer },
                     electricity_bill: { type: :number },
                     power: { type: :number },
                     created_at: { type: :string },
                     updated_at: { type: :string }
                   }
                 }
               })

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
end
